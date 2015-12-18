
make blink   
	Construye en el directorio blink-serial un binario que hace un blink
	para cargar en RAM en la direccion 0xa0040000 con tftpboot
	El binario se llama barebone.bin

make serial   
	Construye en el directorio blink-serial un binario que hace salida
	serial y que se debe cargar
	en RAM en la direccion 0xa0040000 con tftpboot
	El binario se llama barebone.bin


make
	Construye baremetalmr3020.flash.bin, el cual es un binario para
	flashear. El binario se carga en RAM por uboot y simplemente hace un
	j 0xa0040000


Ejemplo de ejecucion desde RAM con uboot

tftpboot 0x81000000 baremetalmr3020.flash.bin
tftpboot 0xa0040000 barebone.bin
bootm 81000000



Ejemplo de ejecucion desde FLASH con uboot

tftpboot 0x80000000 baremetalmr3020.flash.bin
erase 0x9f020000 +0x3c0000
cp.b 0x80000000 0x9f020000 0x3c0000

tftpboot 0xa0040000 barebone.bin

bootm 9f020000
