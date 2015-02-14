// Mandel in Rust
// 2014-06-28 by JRamb
// compile with
// rustc -o mandelrs.rs

use std::os;

type Fl = f32; // f32 is slightly faster than f64

//fn debugvar(s: String, v:int) {
  //// extern crate debug;
  //println!("Type of {} is {} [{:?}]", s, v, v); 
//}

fn mandelzahl(cx: Fl, cy: Fl, max: uint) -> int {
  let mut zx = cx; // first iteration, normally starts with (0,0)
  let mut zy = cy;
  let mut i = 1u;

  let mut x2 = zx * zx;
  let mut y2 = zy * zy;
  while i<max && ( x2 + y2 )<4.0 {
    zy = zx*zy*2. + cy;
    zx = x2 - y2 + cx;
    i += 1;
    x2 = zx * zx;
    y2 = zy * zy;
  }
  if i>=max { -1 } else { i as int }
}

//#[allow(unused_variable)]
fn mandel(w: uint, h: uint, max: uint) {
  let step_h = 2.0 / h as Fl;
  let step_w = 3.0 / w as Fl;
  for _h in range(0, h) {
    let y = -1.0+((_h as Fl)*step_h);
    //let line = ""; //std::string::String.new();
    for _w in range(0, w) {
      let x = -2.0+((_w as Fl)*step_w);
      let mz = mandelzahl(x,y,max);
      print!("{}", if mz>0 { '-' } else { '*' });
      //line.push_char(if mz>0 { '-' } else { '*' });
    }
    println!("");
    //println!("{}", line);
  }
}

fn main() {
  let args = os::args();
  let args = args.as_slice();
  let mut w = 140u;
  let mut h = 50u;
  let mut max = 100000 as uint;

  if args.len()>=4u {
    w = from_str::<uint>(args[1].as_slice()).unwrap();
    h = from_str::<uint>(args[2].as_slice()).unwrap();
    max = from_str::<uint>(args[3].as_slice()).unwrap();
    assert!(w>0 && h>0 && max>0);
  }
  println!("Mandel {} x {}, max={}", w, h, max);
  mandel(w,h,max);
  println!("done");

}

