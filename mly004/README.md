In order to test the implementation, do the following:

1. In the db2700 directory, run make
2. Run ./run_front 
3. When the database has opened, run the command "test" to create the test_table
4. You can now search using the binary search with for example "select * from test_table where test_field1 = 100"
5. In order to test the added functionality to the table search, you need to uncomment the table_search function in schema.c 
and then in interpreter.c you need to change the function call on line 593 from "binary_search" to "table_search" and save
6. Run the command "make clean" and then "make"
7. You can now repeat steps 2-4 to test the linear search
8. In order to duplicate the valgrind results, you must run the following command:
9. valgrind –tool=callgrind –dump-instr=yes –simulate-cache=yes –collect-jumps=yes –collect-atstart=no –instr-atstart=no ./run_front
10. This puts you in the database where you need to repeat steps 3 and 4
11. type "quit" and you will exit the database and get the valgrind results
