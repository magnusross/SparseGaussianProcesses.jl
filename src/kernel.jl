import Base.*

"""
    Kernel

An abstract kernel.
"""
abstract type Kernel end 

"""
    CovarianceKernel

A covariance kernel, assumed symmetric in its arguments.
"""
abstract type CovarianceKernel <: Kernel end

"""
    CrossCovarianceKernel

A cross-covariance kernel, NOT necessarily symmetric in its arguments.
"""
abstract type CrossCovarianceKernel <: Kernel end

"""
    pairwise_column_difference(x::AbstractMatrix, y::AbstractMatrix)

Computes the 3-dimensional distance array, where out dimensions 
are `(input_dimension, x_data_point_dimension, y_data_point_dimension)`.
"""
function pairwise_column_difference(x::AbstractMatrix, y::AbstractMatrix)
  (d1,m) = size(x)
  (d2,n) = size(y)
  reshape(x,(d1,m,1)) .- reshape(y,(d2,1,n))
end

include("kernels/euclidean.jl")


"""
    InterDomainOperator

An abstract inter-domain operator.
"""
abstract type InterDomainOperator end

export IdentityOperator, GradientOperator

"""
    IdentityOperator

The identity inter-domain operator ``\\mathcal{A}f = f``.
"""
struct IdentityOperator <: InterDomainOperator end

"""
    GradientOperator

The gradient inter-domain operator ``\\mathcal{A}f = \\nabla f``.
"""
struct GradientOperator <: InterDomainOperator end

*(k::Kernel, op::IdentityOperator) = k
*(op::IdentityOperator, k::Kernel) = k