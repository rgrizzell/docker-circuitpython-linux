# This is the default variant when you `make` the Unix port.
FROZEN_MANIFEST ?= $(VARIANT_DIR)/manifest.py

SRC_BITMAP := \
	shared/runtime/context_manager_helpers.c \
	displayio_min.c \
	shared-bindings/__future__/__init__.c \
	shared-bindings/aesio/aes.c \
	shared-bindings/aesio/__init__.c \
	shared-bindings/bitmapfilter/__init__.c \
	shared-bindings/bitmaptools/__init__.c \
	shared-bindings/codeop/__init__.c \
	shared-bindings/displayio/Bitmap.c \
	shared-bindings/displayio/ColorConverter.c \
	shared-bindings/displayio/Palette.c \
	shared-bindings/getpass/__init__.c \
	shared-bindings/locale/__init__.c \
	shared-bindings/traceback/__init__.c \
	shared-bindings/util.c \
	shared-bindings/zlib/__init__.c \
	shared-module/aesio/aes.c \
	shared-module/aesio/__init__.c \
	shared-module/bitmapfilter/__init__.c \
	shared-module/bitmaptools/__init__.c \
	shared-module/displayio/area.c \
	shared-module/displayio/Bitmap.c \
	shared-module/displayio/ColorConverter.c \
	shared-module/displayio/Palette.c \
	shared-module/getpass/__init__.c \
	shared-module/os/getenv.c \
	shared-module/struct/__init__.c \
	shared-module/traceback/__init__.c \
	shared-module/zlib/__init__.c \

SRC_C += $(SRC_BITMAP)

CFLAGS += \
	-DCIRCUITPY_AESIO=1 \
	-DCIRCUITPY_BITMAPTOOLS=1 \
	-DCIRCUITPY_CODEOP=1 \
	-DCIRCUITPY_DISPLAYIO_UNIX=1 \
	-DCIRCUITPY_FUTURE=1 \
	-DCIRCUITPY_GETPASS=1 \
	-DCIRCUITPY_LOCALE=1 \
	-DCIRCUITPY_OS_GETENV=1 \
	-DCIRCUITPY_STRUCT=1 \
	-DCIRCUITPY_TRACEBACK=1 \
	-DCIRCUITPY_ZLIB=1