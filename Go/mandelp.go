package main

/*
 2016-01-17 by J Ramb (first go on a Go program)
*/

import (
	//"bytes"
	"fmt"
	"os"
	"runtime"
	"strconv"
	"time"
	//"math/rand"
	"math/cmplx"
)

type fl float64

var (
	z complex128 = cmplx.Sqrt(-5 + 12i)
)

func mandelzahl(cx fl, cy fl, max int) int {
	//var zx, zy, x2, y2 float32
	//var i int
	zx := cx
	zy := cy
	i := 0
	x2 := zx * zx
	y2 := zy * zy
	for (i < max) && (x2+y2) < 4.0 {
		zy = zx*zy*2.0 + cy
		zx = x2 - y2 + cx
		i += 1
		x2 = zx * zx
		y2 = zy * zy
	}
	if i >= max {
		return -1
	} else {
		return i
	}
}

//type chan<- string cm

func mandelLine(y fl, w int, max int, c chan<- string) {
	buffer := make([]byte, w)
	stepX := 3.0 / fl(w)
	for x := 0; x < w; x++ {
		if mz := mandelzahl(-2.0+fl(x)*stepX, y, max); mz >= 0 {
			buffer[int(x)] = byte('a' + (mz % 26))
		} else {
			buffer[x] = ' '
			//buffer.WriteRune(' ')
		}
	}
	c <- string(buffer)
	//return string(buffer)
}

func mandel(w int, h int, max int) {
	stepY := 2.0 / fl(h)
	c := make([]chan string, h)
	for y := 0; y < h; y++ {
		//line :=
		c[y] = make(chan string)
		go mandelLine(-1.0+fl(y)*stepY, w, max, c[y])
	}
	for y := 0; y < h; y++ {
		fmt.Println(<-c[y])
	}
}

func main() {
	argv := os.Args[1:] // without prog (= arg 0)
	defaultArgs := []string{"140", "50", "100000"}[len(argv):]
	argv = append(argv, defaultArgs...)
	fmt.Println(argv)
	var argn [3]int
	for i, v := range argv {
		var err error
		argn[i], err = strconv.Atoi(v)
		if err != nil {
			fmt.Println(err)
		}
	}
	//fmt.Println(argn)
	//w, h, max := argn[0:2]
	w, h, max := argn[0], argn[1], argn[2]
	//fmt.Println(w, h, max)

	fmt.Printf("NumCPU=%d, GOMAXPROCS=%d, GOARCH=%s, GOOS=%s, Version=%s\n",
		runtime.NumCPU(), runtime.GOMAXPROCS(0), runtime.GOARCH, runtime.GOOS, runtime.Version())
	//fmt.Println("Hello, world ", rand.Intn(10))
	fmt.Println(time.Now())
	//fmt.Printf("%T(%v)\n", z, z)
	//mandel(140,50,100000)
	mandel(w, h, max)
}
