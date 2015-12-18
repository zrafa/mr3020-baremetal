
make blink   
	General en el directorio blink-serial un main.c para generar un blink
	Luego se debe compilar todo con make all

make serial   
	General en el directorio blink-serial un main.c para generar realizar una salida serial 
	Luego se debe compilar todo con make all


make all
	Construye una imagen llamada baremetalmr3020.flash.bin, el cual es indicada para
	flashear. 
        uboot carga y ejecuta esta imagen en la dirección RAM SIN CACHE 0xa0040000


Ejemplo de compilacion y ejecucion desde RAM con uboot
------------------------------------------------------

make blink
make all
# Copiar baremetalmr3020.flash.bin al servidor tftp

# Desde uboot en mr3020
tftpboot 0x81000000 baremetalmr3020.flash.bin
bootm 81000000



Ejemplo compilacion y ejecucion desde FLASH con uboot
-----------------------------------------------------

make blink
make all
# Copiar baremetalmr3020.flash.bin al servidor tftp

# Desde uboot en mr3020
tftpboot 0x80000000 baremetalmr3020.flash.bin
erase 0x9f020000 +0x3c0000
cp.b 0x80000000 0x9f020000 0x3c0000
bootm 9f020000
