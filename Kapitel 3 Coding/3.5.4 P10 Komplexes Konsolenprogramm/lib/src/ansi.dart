import 'dart:io';

/**
 * ANSI-Library
 * vereinfacht die Verwendung von ANSI-Steuercodes im Terminal
 * 
 * © 2025 Microwalker
 */


const String ANSI_Escape = "\x1B";

String getANSISequence(String ansiCodeSequencer, {List? values = null}) {
  String ret = ansiCodeSequencer.replaceAll("%ESC%", ANSI_Escape);
  if(ret.contains("%VALUE%")) 
    if(values != null && values.length > 0)
      values.forEach((val) {ret = ret.replaceFirst("%VALUE%", val.value.toString());});
  return ret;
}

void main() {
  String ansi = setANSI_Colour(ANSI_Colours.GREEN);
  print(ansi + "WILLKOMMEN!");
  ansi = setANSI_BackgroundColour256(58);
  print("$ansi ${"...%1%...%2%".contains("%1%")}");
  print("...%1%...%2%".replaceFirst("%1%", "Mein Wert").replaceFirst("%2%", "ist Irgendwas!"));
  ANSI_Colours.values.forEach((value) => stdout.write(setANSI_Colour(value)+" $value "));
  print("\n");
  for(int c=0;c<256;c++) 
    stdout.write(setANSI_ForegroundColour256(c)+" $c ");
  print("\n" + setANSI_ForegroundColourRGB(0xff,0xff,0xff));
  for(int r=0;r<256;r+=16)
    for(int g=0;g<256;g+=16) {
      for(int b=0;b<256;b+=16) 
        stdout.write(setANSI_BackgroundColourRGB(r, g, b)+"${r.toRadixString(16).padLeft(2, "0")+g.toRadixString(16).padLeft(2, "0")+b.toRadixString(16).padLeft(2, "0")} "); 
    stdout.writeln();
    }
  print(resetAllANSI_TextModes());
}

/**
 * 
General ASCII Codes

Name	decimal	octal	hex	C-escape	Ctrl-Key	Description
- BEL	7	007	0x07	\a	^G	Terminal bell
- BS	8	010	0x08	\b	^H	Backspace
- HT	9	011	0x09	\t	^I	Horizontal TAB
- LF	10	012	0x0A	\n	^J	Linefeed (newline)
- VT	11	013	0x0B	\v	^K	Vertical TAB
- FF	12	014	0x0C	\f	^L	Formfeed (also: New page NP)
- CR	13	015	0x0D	\r	^M	Carriage return
- ESC	27	033	0x1B	\e*	^[	Escape character
- DEL	127	177	0x7F	<none>	<none>	Delete character

 */
enum ANSI_General{
  BELL("\a"), BACKSPACE("\b"), HORIZONTAL_TAB("\t"), LF("\n"), VERTICAL_TAB("\v"), FORMFEED("\f"),CR("\m"),ESC("\x1B"),DEL("\x7f");

  const ANSI_General(this.value); 
  final String value; 
}
String getANSI_General(ANSI_General value) => value.value;

/**
Cursor Controls

ESC Code Sequence	Description
- ESC[H	moves cursor to home position (0, 0)
- ESC[{line};{column}H
- ESC[{line};{column}f	moves cursor to line #, column #
- ESC[#A	moves cursor up # lines
- ESC[#B	moves cursor down # lines
- ESC[#C	moves cursor right # columns
- ESC[#D	moves cursor left # columns
- ESC[#E	moves cursor to beginning of next line, # lines down
- ESC[#F	moves cursor to beginning of previous line, # lines up
- ESC[#G	moves cursor to column #
- ESC[6n	request cursor position (reports as ESC[#;#R)
- ESC M	moves cursor one line up, scrolling if needed
- ESC 7	save cursor position (DEC)
- ESC 8	restores the cursor to the last saved position (DEC)
- ESC[s	save cursor position (SCO)
- ESC[u	restores the cursor to the last saved position (SCO)

 */

enum ANSI_Cursor{
  HOME("[H"), LINECOLUMN("[\%LINE%;\%COLH"), CRSR_UP("[\%COUNT%A"), CRSR_DOWN("[\%COUNT%B"), CRSR_RIGHT("[\%COUNT%C"), CRSR_LEFT("[\%COUNT%D"),
  CRSR_NEXTLINE_BEGIN("[E"), CRSR_LINESDOWN_BEGIN("[\%COUNT%E"), CRSR_PREVIOUSLINE_BEGIN("[F"), CRSR_LINESUP_BEGIN("[\%COUNT%F"),
  CRSR_TOCOLUMN("[\%COL%G"), CRSR_LINEUP(" M"), CRSR_SAVEPOS_DEC(" 7"), CRSR_RESTOREPOS_DEC(" 8"), CRSR_SAVEPOS_SCO("[s"), CRSR_RESTOREPOS_SCO("[u");

  const ANSI_Cursor(this.value); 
  final String value; 
}
String getANSI_Cursor(ANSI_Cursor value, {int toLine=0, int toColumn=0, int count=0}) =>
  ANSI_Escape + value.value.replaceAll("%LINE%", toLine.toString()).replaceAll("%COL%", toColumn.toString()).replaceAll("%COUNT%", count.toString());

/**
Erase Functions

ESC Code Sequence	Description
- ESC[J	erase in display (same as ESC[0J)
- ESC[0J	erase from cursor until end of screen
- ESC[1J	erase from cursor to beginning of screen
- ESC[2J	erase entire screen
- ESC[3J	erase saved lines
- ESC[K	erase in line (same as ESC[0K)
- ESC[0K	erase from cursor to end of line
- ESC[1K	erase start of line to the cursor
- ESC[2K	erase the entire line

- ESCc \ec \x1bc  clear screen

 */
enum ANSI_Erasing{ ERASE_DISPLAY("[J"), ERASE_FROMCRSR("[0J"), ERASE_TOSCREENSTART("[1J"), ERASE_ENTIRESCREEN("[2J"),
    ERASE_SAVEDLINES("[3J"), ERASE_TOLINEEND("[K"), ERASE_TOLINEEND2("[0K"), ERASE_TOLINESTART("[1K"),
    ERASE_ENTIRELINE("[2K"), CLEARSCREEN("[2C");

  const ANSI_Erasing(this.value); 
  final String value; 
}
String getANSI_Erasing(ANSI_Erasing value) => ANSI_Escape + value.value;

const _ANSI_SetTextMode = "[%VALUE%m";
String setANSI_TextMode(ANSI_TextModes value) => ANSI_Escape + _ANSI_SetTextMode.replaceAll("%VALUE%", value.value);
const _ANSI_SetGfxTextMode = "[1;34;%VALUE%m";
String setANSI_GfxTextMode(ANSI_TextModes value) => ANSI_Escape + _ANSI_SetGfxTextMode.replaceAll("%VALUE", value.value);
const _ANSI_ResetTextModeAll = "[0m";
String resetANSI_TextMode(ANSI_TextModes value) => ANSI_Escape + _ANSI_SetGfxTextMode.replaceAll("%VALUE%", "2" + value.value);
String resetAllANSI_TextModes() => ANSI_Escape + _ANSI_ResetTextModeAll;

/**
Colors / Graphics Mode

ESC Code Sequence	Reset Sequence	Description
- ESC[0m		      reset all modes (styles and colors)
- ESC[1m	ESC[21m	set bold mode.
- ESC[2m	ESC[22m	set dim/faint mode.
- ESC[3m	ESC[23m	set italic mode.
- ESC[4m	ESC[24m	set underline mode.
- ESC[5m	ESC[25m	set blinking mode
- ESC[7m	ESC[27m	set inverse/reverse mode
- ESC[8m	ESC[28m	set hidden/invisible mode
- ESC[9m	ESC[29m	set strikethrough mode.

ESC[1;34;{...}m		Set graphics modes for cell, separated by semicolon (;).

 */
enum ANSI_TextModes{
  BOLD("1"), DIMFAINT("2"), ITALIC("3"), UNDERLINED("4"), BLINKING("5"), INVERTED("6"), INVISIBLE("7"), STRIKED("8");

  const ANSI_TextModes(this.value); 
  final String value; 
}

/**
 * Konstante zum Setzen einer Farbe (z.B. Vorder- oder Hintergrund)
 * Benötigt eine Vorder- ODER Hintergrundfarbe (aus ANSI_Colours oder ANSI_BrightColours)
 */
const _ANSI_SetColour = "[1;3%FORE%m";
const _ANSI_SetColours = "[2;3%FORE%;4%BACK%m";
const _ANSI_SetBrightColour = "[1;9%FORE%m";
const _ANSI_SetBrightColours = "[2;9%FORE%;10%BACK%m";
String setANSI_Colour(ANSI_Colours foreground, [ANSI_Colours? background = null]) => ANSI_Escape + 
  (background == null ? _ANSI_SetColour : _ANSI_SetColours.replaceAll("%BACK%", background.value)).replaceAll("%FORE%", foreground.value);
String setANSI_BrightColours(ANSI_Colours foreground, [ANSI_Colours? background = null]) => ANSI_Escape + 
  (background == null ? _ANSI_SetBrightColour : _ANSI_SetBrightColours.replaceAll("%BACK%", background.value)).replaceAll("%FORE%", foreground.value);

/**
 * Konstante zum Setzen von 2 Farben (z.B. Vordergrund und Hintergrund)
 * Benötigt eine Vorder- UND Hintergrundfarbe (aus ANSI_Colours oder ANSI_BrightColours)
 */

/**
Color codes

Most terminals support 8 and 16 colors, as well as 256 (8-bit) colors. These colors are set by the user, but have commonly defined meanings.

8-16 Colors

Color Name	Foreground Color Code	Background Color Code
- Black	30	40
- Red	31	41
- Green	32	42
- Yellow	33	43
- Blue	34	44
- Magenta	35	45
- Cyan	36	46
- White	37	47
- Default	39	49
Most terminals, apart from the basic set of 8 colors, also support the "bright" or "bold" colors. These have their own set of codes, mirroring the normal colors, but with an additional ;1 in their codes:

# Set style to bold, red foreground.
\x1b[1;31mHello
# Set style to dimmed white foreground with red background.
\x1b[2;37;41mWorld

 */
enum ANSI_Colours{
  BLACK("0"), RED("1"), GREEN("2"), YELLOW("3"), BLUE("4"), MAGENTA("5"), CYAN("6"), WHITE("7"), DEFAULT("9");

  const ANSI_Colours(this.value); 
  final String value; 
}

/**
Terminals that support the aixterm specification provides bright versions of the ISO colors, without the need to use the bold modifier:

Color Name	Foreground Color Code	Background Color Code
- Bright Black	90	100
- Bright Red	91	101
- Bright Green	92	102
- Bright Yellow	93	103
- Bright Blue	94	104
- Bright Magenta	95	105
- Bright Cyan	96	106
- Bright White	97	107

 */
enum ANSI_BrightColours{
  FOREGOUND_BLACK("90"), FOREGOUND_RED("91"), FOREGOUND_GREEN("92"), FOREGOUND_YELLOW("93"), FOREGOUND_BLUE("94"), FOREGOUND_MAGENTA("95"),
  FOREGOUND_CYAN("96"), FOREGOUND_WHITE("97"), FOREGOUND_DEFAULT("99"), BACKGOUND_BLACK("100"), BACKGOUND_RED("101"), BACKGOUND_GREEN("102"), 
  BACKGOUND_YELLOW("103"), BACKGOUND_BLUE("104"), BACKGOUND_MAGENTA("105"), BACKGOUND_CYAN("106"), BACKGOUND_WHITE("107"), BACKGOUND_DEFAULT("109");

  const ANSI_BrightColours(this.value); 
  final String value; 
}

const _SET_ForegroundColour256 = "[38;5;%VALUE%m";
const _SET_BackgroundColour256 = "[48;5;%VALUE%m";
/**
256 Colors

The following escape codes tells the terminal to use the given color ID:

ESC Code Sequence	Description
- ESC[38;5;{ID}m	Set foreground color.
- ESC[48;5;{ID}m	Set background color.
Where {ID} should be replaced with the color index from 0 to 255 of the following color table:

256 Color table:

- 0-7: standard colors (as in ESC [ 30–37 m)
- 8–15: high intensity colors (as in ESC [ 90–97 m)
- 16-231: 6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
- 232-255: grayscale from dark to light in 24 steps.

Some emulators interpret these steps as linear increments (256 / 24) on all three channels while others may explicitly define these values.

*/

/**
- 0-7: standard colors (as in ESC [ 30–37 m)
- 8–15: high intensity colors (as in ESC [ 90–97 m)
- 16-231: 6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
- 232-255: grayscale from dark to light in 24 steps.
 */
String setANSI_ForegroundColour256(int color256_ID) => ANSI_Escape + _SET_ForegroundColour256.replaceAll("%VALUE%", color256_ID.toString());
/**
- 0-7: standard colors (as in ESC [ 30–37 m)
- 8–15: high intensity colors (as in ESC [ 90–97 m)
- 16-231: 6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
- 232-255: grayscale from dark to light in 24 steps.
 */
String setANSI_BackgroundColour256(int color256_ID) => ANSI_Escape + _SET_BackgroundColour256.replaceAll("%VALUE%", color256_ID.toString());

const _SET_ForegroundColourRGB = "[38;2;%R%;%G%;%B%m";
const _SET_BackgroundColourRGB = "[48;2;%R%;%G%;%B%m";
String setANSI_ForegroundColourRGB(int R, int G, int B) => ANSI_Escape + 
  _SET_ForegroundColourRGB.replaceAll("%R%", R.toString()).replaceAll("%G%", G.toString()).replaceAll("%B%", B.toString());
String setANSI_BackgroundColourRGB(int R, int G, int B) => ANSI_Escape + 
  _SET_BackgroundColourRGB.replaceAll("%R%", R.toString()).replaceAll("%G%", G.toString()).replaceAll("%B%", B.toString());

/**
RGB Colors

More modern terminals supports Truecolor (24-bit RGB), which allows you to set foreground and background colors using RGB.

These escape sequences are usually not well documented.

ESC Code Sequence	Description
- ESC[38;2;{r};{g};{b}m	Set foreground color as RGB.
- ESC[48;2;{r};{g};{b}m	Set background color as RGB.
Note that ;38 and ;48 corresponds to the 16 color sequence and is interpreted by the terminal to set the foreground and background color respectively. Where as ;2 and ;5 sets the color format.
 */

const _ANSI_SetScreenMode = "[=%VALUE%h";
const _ANSI_ResetScreenMode = "[=%VALUE%l";
String setANSI_ScreenMode(ANSI_ScreenModes value) => ANSI_Escape + _ANSI_SetScreenMode.replaceAll("%VALUE%", value.value);
String resetANSI_ScreenMode(ANSI_ScreenModes value) => ANSI_Escape + _ANSI_ResetScreenMode.replaceAll("%VALUE%", value.value);

/**
Screen Modes

Set Mode

ESC Code Sequence	Description
- ESC[={value}h	Changes the screen width or type to the mode specified by value.
- ESC[=0h	40 x 25 monochrome (text)
- ESC[=1h	40 x 25 color (text)
- ESC[=2h	80 x 25 monochrome (text)
- ESC[=3h	80 x 25 color (text)
- ESC[=4h	320 x 200 4-color (graphics)
- ESC[=5h	320 x 200 monochrome (graphics)
- ESC[=6h	640 x 200 monochrome (graphics)
- ESC[=7h	Enables line wrapping
- ESC[=13h	320 x 200 color (graphics)
- ESC[=14h	640 x 200 color (16-color graphics)
- ESC[=15h	640 x 350 monochrome (2-color graphics)
- ESC[=16h	640 x 350 color (16-color graphics)
- ESC[=17h	640 x 480 monochrome (2-color graphics)
- ESC[=18h	640 x 480 color (16-color graphics)
- ESC[=19h	320 x 200 color (256-color graphics)
- ESC[={value}l	Resets the mode by using the same values that Set Mode uses, except for 7, which disables line wrapping. The last character in this escape sequence is a lowercase L.

 */
enum ANSI_ScreenModes{
  MONO_40X25_TEXT("0"), COLOR_40X25_TEXT("1"), MONO_80X25_TEXT("2"), COLOR_80X25_TEXT("3"), 
  COLOR_320X200_GFX_4C("4"), MONO_320X200_GFX("5"), MONO_640X200_GFX("6"), ENABLE_LINEWRAPPING("7"),
  COLOR_320X200_GFX_16C("13"), COLOR_640X200_GFX_16C("14"), MONO_640x350_GFX("15"), COLOR_640X350_GFX_16C("16"),
  MONO_640X480_GFX("17"), COLOR_640X480_GFX_16C("18"), COLOR_320X200_GFX_256C("19");

  const ANSI_ScreenModes(this.value); 
  final String value; 
}

/**
The following escape codes can be used to change the cursor shape

ESC Code Sequence	Description
- ESC[0 q	changes cursor shape to steady block
- ESC[1 q	changes cursor shape to steady block also
- ESC[2 q	changes cursor shape to blinking block
- ESC[3 q	changes cursor shape to steady underline
- ESC[4 q	changes cursor shape to blinking underline
- ESC[5 q	changes cursor shape to steady bar
- ESC[6 q	changes cursor shape to blinking bar

 */
enum ANSI_CursorShape {  
  CRSR_BLOCK("[0 q"), CRSR_BLOCK2("[1 q"), CRSR_BLOCK_BLINKING("[2 q"), CRSR_LINE("[3 q"), CRSR_LINE_BLINKING("[4 q"), CRSR_BAR("[5 q"), CRSR_BAR_BLINKING("[6 q");

  const ANSI_CursorShape(this.value); 
  final String value; 
}
String changeANSI_Cursor(ANSI_CursorShape value) => ANSI_Escape + value.value;

/**
Common Private Modes

These are some examples of private modes, which are not defined by the specification, but are implemented in most terminals.

ESC Code Sequence	Description
- ESC[?25l	make cursor invisible
- ESC[?25h	make cursor visible
- ESC[?47l	restore screen
- ESC[?47h	save screen
- ESC[?1049h	enables the alternative buffer
- ESC[?1049l	disables the alternative buffer

 */
enum ANSI_PrivateModes {
  CRSR_INVISIBLE("?25l"), CRSR_VISIBLE("?25h"), SCREEN_RESTORE("?47l"), SCREEN_SAVE("?47h"), ALTBUF_ENABLE("?1049h"), ALTBUF_DISABLE("?1049l"); 

  const ANSI_PrivateModes(this.value); 
  final String value; 
}
String setANSI_Privates(ANSI_PrivateModes value) => ANSI_Escape + value.value;

/**
 * Konstante für TTY Blinking Mode (benötigt Wert für Millisekungen in %VALUE%)
 */
const _ANSI_TTY_BLINKING = "\e[?16;%VALUE%]";
String setANSI_TTY_Blinking(int millisecs) => ANSI_Escape + _ANSI_TTY_BLINKING.replaceAll("%VALUE%", millisecs.toString());

/**
There is also Line Drawing Mode:

- Enable: ESC + (0
- Disable: ESC + (B
See also: Line/Box Drawing Characters (Link: https://en.wikipedia.org/wiki/Box-drawing_characters)

TTY blinking rate

echo -e '\e[16;500]' > /dev/tty0 # every 500ms

Bock cursor

- Enable: \e[?12h
- Disable: \e[?12l
 */
enum ANSI_LineBoxDrawing { 
  LINEBOX_ENABLE("(0"), LINEBOX_DISABLE("(B"), LB_CRSR_ENABLE("\e[?12h"), LB_CRSR_DISABLE("\e[?12l");

  const ANSI_LineBoxDrawing(this.value); 
  final String value; 
 }
 String setANSI_LineBoxMode(ANSI_LineBoxDrawing value) => ANSI_Escape + value.value;

/**
 * Benötigt den Keyboard-Code und die Belegung mit einem neuen Keyboard-Code (oder als String in "" !!!)
 * z.B. "0;97" für CTRL+F4 und "80" für SHIFT-P (oder '"P"' als String!) als neue Belegung
 */
const _ANSI_REDEFINE_KEY = "[%OLD%;%NEW%p"; 
String redefine_ANSI_Key(String keyOld, String keyNew) => ANSI_Escape + _ANSI_REDEFINE_KEY.replaceAll("%OLD%", keyOld).replaceAll("%NEW%", keyNew);

/**
Keyboard Strings

ESC[{code};{string};{...}p
Redefines a keyboard key to a specified string.

The parameters for this escape sequence are defined as follows:

code is one or more of the values listed in the following table. These values represent keyboard keys and key combinations. 
When using these values in a command, you must type the semicolons shown in this table in addition to the semicolons required 
by the escape sequence. The codes in parentheses are not available on some keyboards. ANSI.SYS will not interpret the codes in 
parentheses for those keyboards unless you specify the /X switch in the DEVICE command for ANSI.SYS.

string is either the ASCII code for a single character or a string contained in quotation marks. For example, both 65 and "A" 
can be used to represent an uppercase A.

IMPORTANT: Some of the values in the following table are not valid for all computers. Check your computer's documentation for values that are different.
List of keyboard strings

Key	Code	SHIFT+code	CTRL+code	ALT+code
- F1	0;59	0;84	0;94	0;104
- F2	0;60	0;85	0;95	0;105
- F3	0;61	0;86	0;96	0;106
- F4	0;62	0;87	0;97	0;107
- F5	0;63	0;88	0;98	0;108
- F6	0;64	0;89	0;99	0;109
- F7	0;65	0;90	0;100	0;110
- F8	0;66	0;91	0;101	0;111
- F9	0;67	0;92	0;102	0;112
- F10	0;68	0;93	0;103	0;113
- F11	0;133	0;135	0;137	0;139
- F12	0;134	0;136	0;138	0;140
- HOME (num keypad)	0;71	55	0;119	--
- UP ARROW (num keypad)	0;72	56	(0;141)	--
- PAGE UP (num keypad)	0;73	57	0;132	--
- LEFT ARROW (num keypad)	0;75	52	0;115	--
- RIGHT ARROW (num keypad)	0;77	54	0;116	--
- END (num keypad)	0;79	49	0;117	--
- DOWN ARROW (num keypad)	0;80	50	(0;145)	--
- PAGE DOWN (num keypad)	0;81	51	0;118	--
- INSERT (num keypad)	0;82	48	(0;146)	--
- DELETE (num keypad)	0;83	46	(0;147)	--
- HOME	(224;71)	(224;71)	(224;119)	(224;151)
- UP ARROW	(224;72)	(224;72)	(224;141)	(224;152)
- PAGE UP	(224;73)	(224;73)	(224;132)	(224;153)
- LEFT ARROW	(224;75)	(224;75)	(224;115)	(224;155)
- RIGHT ARROW	(224;77)	(224;77)	(224;116)	(224;157)
- END	(224;79)	(224;79)	(224;117)	(224;159)
- DOWN ARROW	(224;80)	(224;80)	(224;145)	(224;154)
- PAGE DOWN	(224;81)	(224;81)	(224;118)	(224;161)
- INSERT	(224;82)	(224;82)	(224;146)	(224;162)
- DELETE	(224;83)	(224;83)	(224;147)	(224;163)
- PRINT SCREEN	--	--	0;114	--
- PAUSE/BREAK	--	--	0;0	--
- BACKSPACE	8	8	127	(0)
- ENTER	13	--	10	(0
- TAB	9	0;15	(0;148)	(0;165)
- NULL	0;3	--	--	--
- A	97	65	1	0;30
- B	98	66	2	0;48
- C	99	66	3	0;46
- D	100	68	4	0;32
- E	101	69	5	0;18
- F	102	70	6	0;33
- G	103	71	7	0;34
- H	104	72	8	0;35
- I	105	73	9	0;23
- J	106	74	10	0;36
- K	107	75	11	0;37
- L	108	76	12	0;38
- M	109	77	13	0;50
- N	110	78	14	0;49
- O	111	79	15	0;24
- P	112	80	16	0;25
- Q	113	81	17	0;16
- R	114	82	18	0;19
- S	115	83	19	0;31
- T	116	84	20	0;20
- U	117	85	21	0;22
- V	118	86	22	0;47
- W	119	87	23	0;17
- X	120	88	24	0;45
- Y	121	89	25	0;21
- Z	122	90	26	0;44
- 1	49	33	--	0;120
- 2	50	64	0	0;121
- 3	51	35	--	0;122
- 4	52	36	--	0;123
- 5	53	37	--	0;124
- 6	54	94	30	0;125
- 7	55	38	--	0;126
- 8	56	42	--	0;126
- 9	57	40	--	0;127
- 0	48	41	--	0;129
- -	45	95	31	0;130
- =	61	43	---	0;131
- [	91	123	27	0;26
- ]	93	125	29	0;27
- 92	124	28	0;43
- ;	59	58	--	0;39
- '	39	34	--	0;40
- ,	44	60	--	0;51
- .	46	62	--	0;52
- /	47	63	--	0;53
- `	96	126	--	(0;41)
- ENTER (keypad)	13	--	10	(0;166)
- / (keypad)	47	47	(0;142)	(0;74)
- * (keypad)	42	(0;144)	(0;78)	--
- - (keypad)	45	45	(0;149)	(0;164)
- + (keypad)	43	43	(0;150)	(0;55)
- 5 (keypad)	(0;76)	53	(0;143)	--

 */
// enum ANSI_KeyboardCodes { SeeCOMMENTS }
