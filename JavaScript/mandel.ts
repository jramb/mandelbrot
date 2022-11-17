/* 2014/2022 by JRamb */

function mandelzahl(cx: number, cy: number, max: number) {
    /* z -> z^2 + c */
    let x2: number, y2: number;
    let zx = cx;
    let zy = cy;
    let i = 1;
    while (++i <= max && (x2 = zx * zx) + (y2 = zy * zy) < 4) {
        zy = zx * zy * 2 + cy;
        zx = x2 - y2 + cx;
    }
    return (i > max) ? -1 : i;
};
function mandel(w: number, h: number, max: number) {
    let stepY: number, sb: string, x: number, y: number, stepX: number, mz: number;
    let c_char = "a".charCodeAt(0);
    for (y = -1.0, stepY = 2.0 / h; y <= 1.0; y += stepY) {
        sb = "";
        for (x = -2.0, stepX = 3.0 / w; x <= 1.0; x += stepX) {
            mz = mandelzahl(x, y, max);
            if (mz > 0) {
                sb += String.fromCharCode(c_char + mz % 26 - 1);
            } else {
                sb += '.';
            }
        }
        console.log(sb);
    }
};
mandel(140, 50, 100000);

export{mandel};