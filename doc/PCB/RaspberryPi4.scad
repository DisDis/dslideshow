/*
 * Genera el modelo a usar para realizar diseños relacionados con las Raspberry Pi.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/PCB/RaspberryPi.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:3645641
 */
pcbHeight    = 56;  // Alto del PCB (eje Y).
pcbWidth     = 85;  // Ancho del PCB (eje X).
pcbThickness = 1.4; // Grosor del PCB (eje Z).
//-----------------------------------------------------------------------------
use <./pin.scad>
//-----------------------------------------------------------------------------
/**
 * Devuelve la configuración de los bloques de componentes del PCB.
 * `zSD` es el desplamiento sobre el eje Z del lector de la tarjeta.
 *
 * @param {Float} tolerance Tolerancia a usar para las dimensiones de los bloques.
 *
 * @return {Array[]}
 */
function getBlocks(tolerance = 0) = let(zSD = - pcbThickness - (1.8 + tolerance) / 2 ) [
    // Dimensiones [x,y,z]                                       Color            Posición [x,y,z]        Rotación
    [ [  6.0 + tolerance, 15.00 + tolerance,  6.0 + tolerance ], "Cyan",          [ 53.50,  5.00,  0.0 ],      0 ], // 0 A/V
    [ [ 50.8 + tolerance,  5.08 + tolerance,  8.5 + tolerance ], "DarkSlateGray", [ 32.40, 52.50,  0.0 ],      0 ], // 1 GPIO
    [ [  4.0 + tolerance, 22.40 + tolerance,  5.5 + tolerance ], "Orange",        [ 45.00, 11.50,  0.0 ],      0 ], // 2 Cámara
    [ [  4.0 + tolerance, 22.40 + tolerance,  5.5 + tolerance ], "DarkOrange",    [  3.80, 28.00,  0.0 ],      0 ], // 3 Display
    [ [ 15.9 + tolerance, 21.20 + tolerance, 13.5 + tolerance ], "Violet",        [ 76.50, 10.25,  0.0 ],     90 ], // 4 Ethernet
    [ [ 15.5 + tolerance, 11.50 + tolerance,  6.3 + tolerance ], "Cyan",          [ 32.00,  4.55,  0.0 ],      0 ], // 5 HDMI
    [ [ 14.6 + tolerance, 14.60 + tolerance,  1.8 + tolerance ], "Purple",        [  7.30, 28.80,  zSD ],      0 ], // 6 Micro SD
    [ [  8.0 + tolerance,  6.00 + tolerance,  3.1 + tolerance ], "Silver",        [ 10.60,  1.40,  0.0 ],      0 ], // 7 Micro USB
    [ [ 13.1 + tolerance, 17.30 + tolerance, 16.8 + tolerance ], "Silver",        [ 78.45, 47.00,  0.0 ],     90 ], // 8 USB 1
    [ [ 13.1 + tolerance, 17.30 + tolerance, 16.8 + tolerance ], "Silver",        [ 78.45, 29.00,  0.0 ],     90 ], // 9 USB 2
];

/**
 * Devuelve las coordenadas de los agujeros del PCB.
 *
 * @return {Float[]}
 */
function getHoles() = [
    [ 3.5, 61.5 ], // X
    [ 3.5, 52.5 ]  // Y
];

/**
 * Devuelve las dimensiones del PCB.
 *
 * @param {Float} tolerance Tolerancia a usar para las dimensiones del PCB..
 *
 * @return {Float[]}
 */
function getPcbDimensions(tolerance = 0) = [
    pcbWidth     + tolerance, // X
    pcbHeight    + tolerance, // Y
    pcbThickness + tolerance  // Z
];

/**
 * Las siguientes funciones devuelven el índice que corresponde con el bloque, evitando
 * el uso de valores mágicos en el código que pueden rompe el diseño si se modifican.
 *
 * @return {Integer}
 */
function RPI_B_AV()      = 0;
function RPI_B_GPIO()    = 1;
function RPI_B_CAM()     = 2;
function RPI_B_DISPLAY() = 3;
function RPI_B_ETH()     = 4;
function RPI_B_HDMI()    = 5;
function RPI_B_MSD()     = 6;
function RPI_B_MUSB()    = 7;
function RPI_B_USB1()    = 8;
function RPI_B_USB2()    = 9;

/**
 * Las siguientes funciones devuelven el índice que con el tipo de información que almacena cada bloque.
 *
 * @return {Integer}
 */
function RPI_T_SIZE()  = 0;
function RPI_T_COLOR() = 1;
function RPI_T_POS()   = 2;
function RPI_T_ROT()   = 3;

/**
 * Genera el módulo del conector de A/V.
 * Se usa para redondear el conector y que no quede tan cuadrado el bloque.
 *
 * @param {Float} tolerance Tolerancia a usar para las dimensiones del bloque.
 */
module av(tolerance = 0)
{
    _ID_AV  = RPI_B_AV();
    _config = getBlocks(tolerance)[_ID_AV];
    _size   = _config[RPI_T_SIZE()];
    _y1     = _size[1];
    _y2     =  2.5 + tolerance;
    difference()
    {
        // Dibujamos el bloque.
        block(_ID_AV);
        // Dibujamos la parte cilíndrica del conector,
        color(_config[RPI_T_COLOR()])
        {
            _pos = _config[RPI_T_POS()];
            translate([ _pos[0], _pos[1] - _size[1] / 2 + 2.501, _size[2] / 2 ])
            {
                rotate([ 90, 0, 0 ])
                {
                    difference()
                    {
                        cylinder(d = _size[0] + 5, h = _y2 + 1);
                        cylinder(d = _size[0]    , h = _y2 + 1.01);
                    }
                }
            }
        }
    }
}

/**
 * Dibuja un bloque.
 *
 * @param {Integet} index     Índice del bloque a dibujar.
 * @param {Float}   tolerance Tolerancia a usar para las dimensiones del bloque.
 * @param {Float}   offset    Desplazamiento adicional del bloque.
 */
module block(index, tolerance = 0, offset = [ 0, 0, 0 ])
{
    _config = getBlocks(tolerance)[index];
    _size   = _config[RPI_T_SIZE()];
    _pos    = _config[RPI_T_POS()];
    translate([ _pos[0], _pos[1], _pos[2] ? _pos[2] + tolerance / 2 : _size[2] / 2 - tolerance / 2 ] + offset)
    {
        color(_config[RPI_T_COLOR()])
        {
            rotate([ 0, 0, _config[RPI_T_ROT()] ])
            {
                cube(_size, center = true);
            }
        }
    }
}

/**
 * Dibuja el logo de Raspberry Pi.
 * Se debe especificar `width` o `height` pero no ambos.
 * Si no se especifican se reduce al 50%.
 *
 * @param {Float} width  Ancho del logo.
 * @param {Float} height Alto del logo.
 * @param {Float} length Grosor del logo.
 */
module logo(width = 0, height = 0, length = 1)
{
    _b = 6.7;   // Margen inferior que tiene el logo.
    _l = 8.15;  // Margen izquierdo que tiene el logo.
    _h = 206.3; // Altura del logo.
    _w = 157.5; // Anchura del logo.
    _s = width  // Escala de la imagen.
        ? width  / _w
        : height
            ? height / _h
            : 0.5;
    color("red")
    {
        translate([ - (width  ? width  : _w * _s) / 2, - (height ? height : _h * _s) / 2, 0 ])
        {
            linear_extrude(height = length, convexity = 10)
            {
                translate([ - _l * _s, - _b * _s ])
                {
                    import(file = "./RaspberryPi-Logo.dxf", scale = _s);
                }
            }
        }
    }
}

/**
 * Dibuja solamente el circuito impreso, sin incluir los bloques.
 *
 * @param {Float} thickness Grosor del PCB.
 * @param {Float} diameter  Diámetro de cada tornillo.
 * @param {Float} delta     Factor de ampliación/reducción del PCB.
 * @param {Float} tolerance Tolerancia a usar para las dimensiones del PCB.
 *                          Un valor positivo aumenta el tamaño.
 */
module pcb(thickness = pcbThickness, diameter = 2.75, delta = 0, tolerance = 0)
{
    _r = 3;                     // Radio de los bordes del PCB.
    _h = pcbHeight + tolerance; // Alto del PCB (eje Y).
    _w = pcbWidth  + tolerance; // Ancho del PCB (eje X).
    color("LimeGreen")
    {
        translate([ 0, 0, - thickness ])
        {
            linear_extrude(thickness, convexity = 10)
            {
                difference()
                {
                    // PCB
                    roundedRect([ - delta, _w + delta ], [ - delta, _h + delta ], _r);
                    if (diameter)
                    {
                        // Agujeros para los tornillos.
                        _holes = getHoles();
                        for (_x = _holes[0])
                        {
                            for (_y = _holes[1])
                            {
                                translate([ _x, _y ])
                                {
                                    circle(d = diameter);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

/**
 * Dibuja la Raspberry Pi 4
 *
 * @param {Float} tolerance Tolerancia a usar para las dimensiones de los bloques.
 */
module raspberry4(tolerance = 0)
{
    _blocks = getBlocks(tolerance);
    difference()
    {
        pcb(tolerance = tolerance);
        // Imprimimos el logo
        _cam = _blocks[RPI_B_CAM()][RPI_T_POS()][0];
        _dis = _blocks[RPI_B_DISPLAY()][RPI_T_POS()][0];
        translate([ (_cam + _dis) / 2, (pcbHeight + tolerance) / 2, - 0.1 ])
        {
            rotate([ 0, 0, 270 ])
            {
                logo((_cam - _dis) / 2, length = 0.2);
            }
        }
    }
    // Omitimos A/V y GPIO ya que los renderizamos con el código que sigue al `for`.
    for (n = [ RPI_B_CAM() : len(_blocks) - 1 ])
    {
        block(n);
    }
    // Renderizamos A/V y GPIO.
    av(tolerance);
    _gpio = _blocks[RPI_B_GPIO()];
    _pos  = _gpio[RPI_T_POS()];
    _size = _gpio[RPI_T_SIZE()];
    translate([ - _size[0] / 2 + _pos[0], _size[1] / 2 + _pos[1], 0.01 ])
    {
        rotate([ 0, 0, 270 ])
        {
            pcbPinConnector(length = 8.5 + 2.5);
        }
    }
}

/**
 * Dibuja un rectángulo con los bordes redondeados.
 *
 * @param {Float[]} x Valores mínimo y máximo del eje X.
 * @param {Float[]} y Valores mínimo y máximo del eje Y.
 * @param {Float}   r Radios del borde.
 */
module roundedRect(x, y, r = 3)
{
    hull()
    {
        for (_x = x + [ r, -r ])
        {
            for (_y = y + [ r, -r ])
            {
                translate([ _x, _y ])
                {
                    circle(r = r);
                }
            }
        }
    }
}
