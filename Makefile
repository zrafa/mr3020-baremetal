


all: baremetalmr3020 

blink:
	cd blink-serial-a0040000 && make clean && cp main.c.blink main.c && make

serial:
	cd blink-serial-a0040000 && make clean && cp main.c.serial main.c && make

baremetalmr3020:
	cd baremetal-on-flash && make clean
	cd baremetal-on-flash && make
	cp baremetal-on-flash/barebone.elf baremetalmr3020.elf
	mips-openwrt-linux-uclibc-objcopy -O binary -R .reginfo -R .notes -R .note -R .comment -R .mdebug -R .note.gnu.build-id -S baremetalmr3020.elf   baremetalmr3020.bin
	./lzma e baremetalmr3020.bin -lc1 -lp2 -pb2 baremetalmr3020.bin.lzma
	dd if=/dev/zero of=root.jffs2-64k bs=1M count=1
	echo -ne '\xde\xad\xc0\xde' >> root.jffs2-64k
	./mktplinkfw -H 0x00110101 -W 1 -F 4Mlzma -N OpenWrt -V r32741  -k ./baremetalmr3020.bin.lzma -r ./root.jffs2-64k -a 0x10000 -j -o baremetalmr3020.flash.bin
	# ./mktplinkfw -E 0xa0040000 -L 0xa0040000 -H 0x00110101 -W 1 -F 4Mlzma -N OpenWrt -V r32741  -k ./baremetalmr3020.bin.lzma -r ./root.jffs2-64k -a 0x10000 -j -o baremetalmr3020.flash.bin

clean:
	rm -rf  baremetalmr3020.elf baremetalmr3020.bin baremetalmr3020.bin.lzma root.jffs2-64k baremetalmr3020.flash.bin 

