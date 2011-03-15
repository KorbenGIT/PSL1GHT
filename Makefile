#---------------------------------------------------------------------------------
# Clear the implicit built in rules
#---------------------------------------------------------------------------------
.SUFFIXES:
#---------------------------------------------------------------------------------
ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>devkitPro")
endif

ifeq ($(strip $(DEVKITPS3)),)
$(error "Please set DEVKITPS3 in your environment. export DEVKITPS3=<path>")
endif

all: install-ctrl
	@make -C common --no-print-directory
	@make -C ppu --no-print-directory
	@make -C spu --no-print-directory
	@make -C tools --no-print-directory

install-ctrl:
	@[ -d $(DEVKITPS3) ] || mkdir -p $(DEVKITPS3)
	@[ -f $(DEVKITPS3)/base_rules ] || cp -frv base_rules $(DEVKITPS3)
	@[ -f $(DEVKITPS3)/ppu_rules ]  || cp -frv ppu_rules  $(DEVKITPS3)
	@[ -f $(DEVKITPS3)/spu_rules ]  || cp -frv spu_rules  $(DEVKITPS3)
	
install-socat:
	@make -C tools install-socat --no-print-directory	
	
install:
	@make -C common install --no-print-directory
	@make -C ppu install --no-print-directory
	@make -C spu install --no-print-directory
	@make -C tools install --no-print-directory
	
clean:
	@make -C common clean --no-print-directory
	@make -C ppu clean --no-print-directory
	@make -C spu clean --no-print-directory
	@make -C tools clean --no-print-directory
	
.PHONY: all clean install
