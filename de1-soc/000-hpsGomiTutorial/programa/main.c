#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#define soc_cv_av
#include "hwlib.h"
// #include "socal/socal.h"
// #include "socal/hps.h"
// #include "socal/alt_gpio.h"
#include "soc_cv_av/socal/socal.h"
#include "soc_cv_av/socal/hps.h"
#include "soc_cv_av/socal/alt_gpio.h"
#include "../hps_0.h"


#define REG_BASE 0xFF200000
#define REG_SPAN 0x00200000

void* virtual_base;
void* led_addr;
void* sw_addr;
int fd;
int switches;

int main (){
  fd=open("/dev/mem",(O_RDWR|O_SYNC));
  virtual_base=mmap(NULL,REG_SPAN,(PROT_READ|PROT_WRITE),MAP_SHARED,fd,REG_BASE);
  sw_addr=virtual_base+CHAVES_BASE;
  led_addr=virtual_base+LEDS_BASE;

  while(1){
    switches=*(uint32_t *)sw_addr;
    *(uint32_t *)led_addr=switches+1;
    usleep(1000000);
    printf("%u (%u)\n",switches,switches+1);
  }
  return 0;
}
