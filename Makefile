all: mandelrs

mandelrs: mandelrs.rs
	rustc -O $^

.PHONY: all
