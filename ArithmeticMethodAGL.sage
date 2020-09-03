#!/usr/bin/env sage
# -*- coding: utf-8 -*-

"""
Arithmetic Method AGL

This is a SageMath script that computes the E-polynomial of the
AGL_1(C)-representation variety over a compact orientable surface of genus g,
Sigma_g. That is, the space of representations of the fundamental group of
Sigma_g into the group of affine transformations of the complex line

	rho: pi_1(Sigma_g) -> AGL_1(C).


The computation is performed by counting the number of points of the
representation variety over the finite field of q elements. The calculation is
based on the result of Katz in [2]. 

From this calculation for small genus, the existence of a Topological Quantum
Field Theory computing the E-polynomials allows us to compute the E-polynomial
for arbitrary genus. For further information about the method, please check [1].

References

[1] Á. González-Prieto, M. Logares and V. Muñoz, Representation variety for the
rank one affine group, arXiv:2005.01841.

[2] T. Hausel and F. Rodrı́guez-Villegas, Mixed Hodge polynomials of character
varieties. With an appendix by Nicholas M. Katz, Invent. Math.,
174 (2008), 555–624.

Authors: Ángel González-Prieto (Universidad Politécnica de Madrid)
	 Marina Logares (Universidad Complutense de Madrid)
	 Vicente Muñoz (Universidad de Málaga)
"""

from sage.all import *

def generate_beta(s, k):
    '''
    Generates the possible values of beta = (beta_1, ..., beta_s)
    in the field k for the variety X_s of Section 4.2 of [1].
        
    Parameters

        s : int
            Length of the generated tuples (half of the genus
            of the underlying surface)
        k : Field
            Ground field in which the tuple takes values

    Returns
    
        list
            A list of tuples of length s with
            the possible values of beta
    '''
    if s == 0:
        return [[]]
    else:
        betas = generate_beta(s-1, k)
        result = []
        for beta_tuple in betas:
            for beta in k:
                result.append(beta_tuple + [beta])
    return result

def generate_alpha(s, k):
    '''
    Generates the possible values of alpha = (alpha_1, ..., alpha_s)
    in the field k for the variety X_s of Section 4.2 of [1].
    
    Recall that, unlike beta, alpha cannot take the value -1.
    
    Parameters

        s : int
            Length of the generated tuples (half of the genus
            of the underlying surface)
    
        k : Field
            Ground field in which the tuple takes values

    Returns

        list
            A list of tuples of length s with
            the possible values of alpha
    '''
    if s == 0:
        return [[]]
    else:
        alphas = generate_alpha(s-1, k)
        result = []
        for alpha_tuple in alphas:
            for alpha in k:
                if alpha != -1: # -1 is not allowed for alpha
                    result.append(alpha_tuple + [alpha])
    return result

def count_points(g, q):
    '''
    Counts the number of points of the AGL(1, F_q)-representation
    variety of the compact orientable surface of genus g.
    
    Here, F_q is the finite field of q elements.
    
    Parameters
    
        g : int
            Positive integer denoting the genus of the surface
        q : int
            Number of elements of the underlying field

    Returns

        int
            Number of points of the representation variety
    '''

    k = GF(q)
    betas = generate_beta(2*g, k)
    alphas = generate_alpha(2*g, k)
    
    n_points = 0
    counter = int(0)
    
    # Shows a message each 10% of computation
    step_msg = ceil(len(betas)/10)
    for beta in betas:
        if step_msg > 0 and counter % step_msg == 0:
            print('--> ' + str(counter / step_msg * 10) + '%')
        counter += 1
        
        for alpha in alphas:
            # Checks the equation defining
            # the representation variety
            if sum([alpha[i]*beta[i] for i in range(2*g)]) == 0:
                n_points += 1
    return n_points


def compute_values(g, d):
    '''
    Computes the values of the E-polynomial (the number of points)
    of the representation variety over the surface of genus g
    up to degree d.
    
    Parameters
    
        g : int
            Positive integer denoting the genus of the surface
        d : int
            Maximum degree up to which computation is performed

    Returns

        list (int)
            List with the number of points of the representation
            over a field with a power prime order.
            
            Each element is of the form [q, n_points], where q
            is the order of the underlying field and n_points is
            the number of points of the representation variety.
    '''
    values = []
    n_values = 0
    q = 1
    while n_values < d + 1:
        q += 1
        if is_prime_power(q):
            print('Computing for g = ' + str(g)\
                  + ' and q = '+str(q))
            n_points = count_points(g, q)
            values.append([q, n_points])
            n_values += 1
    
    return values

def compute_polynomial(g, deg_estimate):
    '''
    Computes the E-polynomial of the AGL(1,C)-representation variety
    over the genus g surface.
    
    This function requieres an upper bound, deg_estimate, of the
    degree of the E-polynomial.
    
    Parameters
    
        g : int
            Positive integer denoting the genus of the surface
        deg_estimate : function :: int -> int
            Function such that, for each genus g, deg_estimate(g)
            is an upper bound on the number of points of the genus
            g representation variety.

    Returns

        Polynomial
            E-polynomial of the representation variety over the
            surface of genus g.
    '''
    d = deg_estimate(g)
    values = compute_values(g, d)
    R = PolynomialRing(QQ, 'q')
    P_counted = R.lagrange_polynomial(values)
    return P_counted

def compute_polynomials(g_max):
    '''
    Computes the E-polynomial of the AGL(1,C)-representation variety over
    the genus g surface for g = 1, 2, ..., g_max. 
    
    Parameters
    
        g_max : int
            Maximum genus to which the E-polynomial will be computed

    Returns

        list (Polynomial)
            A list with the E-polynomials
            ordered by genus.
    '''
    result = [0]*(g_max+1)
    deg_estimate = lambda g: 4*g -1
    for g in range(1, g_max+1):
        result[g] = compute_polynomial(g, deg_estimate)
        print('+++++++++++++++++')
        show('\\textrm{Result for }g = ' + str(g) + ': ' + latex(result[g]))
        print('+++++++++++++++++')
        
    return result
