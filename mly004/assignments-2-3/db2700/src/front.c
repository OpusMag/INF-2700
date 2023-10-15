#include "interpreter.h"
#include <valgrind/callgrind.h>

int main (int argc, char* argv[])
{
  CALLGRIND_TOGGLE_COLLECT;
  CALLGRIND_START_INSTRUMENTATION;
  interpret (argc, argv);
  return (0);
  CALLGRIND_TOGGLE_COLLECT;
  CALLGRIND_STOP_INSTRUMENTATION;
}
