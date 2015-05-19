INC=-I$SGE_ROOT/include 
LIB=-L$SGE_ROOT/lib/sol-x86/
LIB_NAME=-ldrmaa
cc $INC $LIB $LIB_NAME sge_drmaa_test_example.c -o sge_drmaa_test_example.out

 
