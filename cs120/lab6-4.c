#include <stdio.h>

int main()
{
  char c;

  for(c = 'A'; c <= 'Z'; c = c +1)
  {
    printf("Character %c: %d decimal | 0x%x hex\n", c, c, c);
  }
}
