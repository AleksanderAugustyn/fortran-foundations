!> Shared constants and status codes for shape parameterization libraries
!! (the shape_core deliverable of the shape parameterization contract,
!! atlas contracts/shape-parameterization-api.md).
!!
!! Constants only. Adopting libraries raise every code; the codes live here
!! so every library reports the same code for the same failure.
module shape_core_mod

    use precision_utilities_mod, only: ik

    implicit none
    private

    public :: SHAPE_MAX_PARAMS
    public :: SHAPE_VALID
    public :: SHAPE_ERROR_TOO_MANY_PARAMS
    public :: SHAPE_ERROR_CACHE_NOT_INITIALIZED
    public :: SHAPE_ERROR_INVALID_GRID
    public :: SHAPE_ERROR_WRONG_PARAM_COUNT
    public :: SHAPE_ERROR_INVALID_INIT

    !> Ceiling on the parameter count for both tiers. The effective limit
    !! per library is min(SHAPE_MAX_PARAMS, N_max).
    integer(kind = ik), parameter :: SHAPE_MAX_PARAMS = 64_ik

    ! Shared status codes (contract range 0-99, append-only: no code is
    ! renumbered or reused). 6 is retired - it was
    ! SHAPE_ERROR_TABLES_NOT_INITIALIZED - and 7-99 are reserved.
    !> Success.
    integer(kind = ik), parameter :: SHAPE_VALID = 0_ik
    !> max_params at cache init, or a one-shot vector, exceeds the library
    !! limit.
    integer(kind = ik), parameter :: SHAPE_ERROR_TOO_MANY_PARAMS = 1_ik
    !> A compute call or a setup-type build receives an uninitialized cache.
    integer(kind = ik), parameter :: SHAPE_ERROR_CACHE_NOT_INITIALIZED = 2_ik
    !> Invalid resolution arguments: grid below the library's documented
    !! floor; per library, also an invalid theta set or an unallocatable grid.
    integer(kind = ik), parameter :: SHAPE_ERROR_INVALID_GRID = 3_ik
    !> size(params) outside 1..max_params (cached) or empty (one-shot).
    integer(kind = ik), parameter :: SHAPE_ERROR_WRONG_PARAM_COUNT = 4_ik
    !> max_params < 1, or another invalid init argument not covered above.
    integer(kind = ik), parameter :: SHAPE_ERROR_INVALID_INIT = 5_ik

end module shape_core_mod
