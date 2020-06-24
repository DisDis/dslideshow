/*
 * Genera el modelo a usar para realizar diseños relacionados con las Raspberry Pi.
 *
 * @author  Joaquín Fernández
 * @url     https://gitlab.com/joaquinfq/openscad/blob/master/Modules/Models/PCB/RaspberryPi.scad
 * @license CC-BY-NC-4.0
 * @see     http://www.thingiverse.com/thing:3645641
 */
pcbHeight    = 67.5;  // Alto del PCB (eje Y).
pcbWidth     = 65;  // Ancho del PCB (eje X).
pcbThickness = 1.6; // Grosor del PCB (eje Z).
pcbName = "Display Driver";
pcbNameSize = 5;
pcbHoleDiam = 3.5;
//-----------------------------------------------------------------------------
//use <./pin.scad>
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
    [ [  4.0 + tolerance, 40.0 + tolerance,  2.0 + tolerance ], "DarkOrange",    [  3.80, 32.00,  0.0 ],      0 ], // 3 Display
    [ [ 15.5 + tolerance, 11.50 + tolerance,  6.3 + tolerance ], "Cyan",          [ 15.00,  4.55,  0.0 ],      0 ], // 5 HDMI
    [ [  8.0 + tolerance,  6.00 + tolerance,  3.1 + tolerance ], "Silver",        [ 32.00,  1.40,  0.0 ],      0 ], // 7 Micro USB
];

hole1x = 0.75 + pcbHoleDiam / 2;
hole1y= 0.75 + pcbHoleDiam / 2;
/**
 * Devuelve las coordenadas de los agujeros del PCB.
 *
 * @return {Float[]}
 */
function getPcbDisplayDriverHoles() = [
    [ hole1x                     , hole1y - 0.3 ], /* magic 0.3 */
    [ hole1x                     , hole1y + 58.6 + pcbHoleDiam ], 
    [ hole1x + 56.6 + pcbHoleDiam, hole1y ], 
    [ hole1x + 56.6 + pcbHoleDiam, hole1y + 58.6 + pcbHoleDiam ]
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
 * Las siguientes funciones devuelven el índice que con el tipo de información que almacena cada bloque.
 *
 * @return {Integer}
 */
function RPI_T_SIZE()  = 0;
function RPI_T_COLOR() = 1;
function RPI_T_POS()   = 2;
function RPI_T_ROT()   = 3;

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
module printPcbName(width = 0, height = 0, length = 1)
{
    color("red")
    {
       // translate([ - (width  ? width  : _w * _s) / 2, - (height ? height : _h * _s) / 2, 0 ])
        {
            linear_extrude(height = length, convexity = 10)
            {
                text(pcbName, pcbNameSize);
            }
            rotate([0,180,0]) translate([-pcbWidth,0,pcbThickness-length]) linear_extrude(height = length, convexity = 10)
            {
                text(pcbName, pcbNameSize);
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
module pcb(thickness = pcbThickness, diameter = 2.75, delta = 0, tolerance = 0, radius = 0.1)
{
    _r = radius;                     // Radio de los bordes del PCB.
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
                        _holes = getPcbDisplayDriverHoles();
                        for (_xy = _holes)
                        { 
                                translate([ _xy[0], _xy[1] ])
                                {
                                    circle(d = diameter, $fn = 20);
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
module pcbDisplayDriver(tolerance = 0)
{
    _blocks = getBlocks(tolerance);
    //difference()
    //{
        pcb(diameter = pcbHoleDiam, tolerance = tolerance);
        translate([ (pcbWidth) / 2, (pcbHeight + tolerance), - 0.1 ])
        {
            rotate([ 0, 0, 270 ])
            {
                printPcbName((pcbWidth) / 2, length = 0.2);
            }
        }
    //}
   
    for (n = [ 0 : len(_blocks) - 1 ])
    {
        block(n);
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

pcbDisplayDriver();