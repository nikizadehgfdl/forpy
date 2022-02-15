#define errcheck if(ierror/=0) then;call err_print;stop;endif 
program simple_example
  use forpy_mod
  implicit none

  integer :: ierror
  type(module_py) :: mymodule
  type(list) :: paths

  ierror = forpy_initialize()

  ! Instead of setting the environment variable PYTHONPATH,
  ! we can add the current directory "." to sys.path
  ierror = get_sys_path(paths)
  ierror = paths%append(".")
  ierror = import_py(mymodule, "simple_example")

  call simple_print(mymodule)
  !call simple_plot(mymodule)

  call mymodule%destroy
  call paths%destroy
  
  call forpy_finalize

  CONTAINS

  subroutine simple_plot(mymodule)
    type(module_py) :: mymodule
    integer :: ierror, ii
    real, parameter :: PI = 3.1415927
    integer, parameter :: NPOINTS = 200
    real :: x(NPOINTS)
    real :: y(NPOINTS)
    type(tuple) :: args
    type(object) :: return_value
    character(len=:), allocatable :: return_string
    type(ndarray) :: x_arr, y_arr


    do ii = 1, NPOINTS
      x(ii) = ((ii-1) * 2. * PI)/(NPOINTS-1)
      y(ii) = sin(x(ii))
    enddo
    ierror = ndarray_create_nocopy(x_arr, x)
    errcheck
    ierror = ndarray_create_nocopy(y_arr, y)
    errcheck
    ierror = tuple_create(args, 2)
    errcheck
    ierror = args%setitem(0, x_arr)
    errcheck
    ierror = args%setitem(1, y_arr)
    errcheck

    ierror = call_py(return_value, mymodule, "py_plot1Darray", args)
    ierror = cast(return_string, return_value)
    write(*,*) return_string
    call return_value%destroy
  end subroutine simple_plot

  subroutine simple_print(mymodule)
    type(module_py) :: mymodule
    integer :: ierror
    type(tuple) :: args
    type(dict) :: kwargs
    type(object) :: return_value
    character(len=:), allocatable :: return_string
    ierror = tuple_create(args, 3)
    ierror = args%setitem(0, 12)
    ierror = args%setitem(1, "Hi")
    ierror = args%setitem(2, .true.)

    ierror = dict_create(kwargs)
    ierror = kwargs%setitem("message", "Hello world!")

    ierror = call_py(return_value, mymodule, "print_args", args, kwargs)

    ierror = cast(return_string, return_value)
    write(*,*) return_string

    call args%destroy
    call kwargs%destroy

  end subroutine simple_print

end program
