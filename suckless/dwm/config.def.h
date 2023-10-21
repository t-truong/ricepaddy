/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 20;       /* gaps between windows */
static const unsigned int snap      = 20;       /* snap pixel */

static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int horizpadbar        = 0;        /* horizontal padding for statusbar */
static const int vertpadbar         = 0;        /* vertical padding for statusbar */
static const int vertpad            = 10;       /* vertical padding of bar */
static const int sidepad            = 25;       /* horizontal padding of bar */

static const char *fonts[]          = { "SpaceMono Nerd Font:style=Bold:pixelsize=15" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#ff0000";
static const char col_silver[]      = "#d5eaeb";
static const char col_trueblack[]   = "#000000";
static const char col_purple[]      = "#6b16e0";
static const char col_skyblue[]     = "#549eff";
static const unsigned int baralpha    = 175;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]      = {
	/*               fg                bg               border        */
	[SchemeNorm] = { col_trueblack,    col_purple,      col_silver    },
	[SchemeSel]  = { col_trueblack,    col_purple,      col_purple    },
};
static const unsigned int alphas[][3]      = {
    /*               fg      bg        border*/
    [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { " ", "󰆍", "󰖟", "󰍹", "󰍹", "󰍹" }; //invisble 1st tag as visual offset

static const unsigned int ulinepad	    = 0;    /* horizontal padding between the underline and tag */
static const unsigned int ulinestroke	= 2;    /* thickness / height of the underline */
static const unsigned int ulinevoffset	= 0;    /* how far above the bottom of the bar the line should appear */
static const int ulineall 		        = 0;    /* 1 to show underline on all tags, 0 for just the active ones */

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class              instance    title          tags mask      isfloating    monitor */
	{ "",                 NULL,       NULL,          0,             1,            -1    }, //all other windows open as floating on current tag
    { "st-256color",      NULL,       "stsquare",    0,             0,            -1    }, //"st -T 'stsquare'" will create st with title 'stsquare' to match this rule
                                                                                           //and force always to be tile mode
    { "st-256color",      NULL,       "stinit",      1<<1,          0,            -1    }, //sets up special tile mode st on 2nd tag on xinit
                                                                                           //1st tag is invisible visual offset tag
	{ "Brave-browser",    NULL,       NULL,          1<<2,          0,            -1    }, //brave always floating and on tag 3
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol          arrange function */
	{ "| 󰕮 |",    tile },    /* first entry is default */
	{ "| 󰕕 |",    NULL },    /* no layout function means floating behavior */
	{ "| 󰍅 |",    monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
//modified TAGKEYS
#define TAGKEYS(KEY,TAG) \
	{ Mod4Mask,                     KEY,      view,           {.ui = 1 << TAG} }, \
	{ Mod4Mask|ShiftMask,           KEY,      tag,            {.ui = 1 << TAG} }, \
// 	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
// 	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_trueblack, "-sb", col_skyblue, "-sf", col_purple, NULL };
static const char *termcmd[]  = { "st", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
// 	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },   //dmenu not installed
	{ Mod4Mask,                     XK_t,      spawn,          {.v = termcmd } },    //modified [Win]+[t], spawn st
// 	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ Mod4Mask,                     XK_Left,   focusstack,     {.i = +1 } },         //modified [Win]+[Left],  focus next in stack
	{ Mod4Mask,                     XK_Right,  focusstack,     {.i = -1 } },         //modified [Win]+[Right], focus prev in stack
// 	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
// 	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
// 	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
// 	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
// 	{ MODKEY,                       XK_Return, zoom,           {0} },
// 	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ Mod4Mask,                     XK_c,      killclient,     {0} },                //modified [Win]+[c], kill client
	{ Mod4Mask,                     XK_s,      setlayout,      {.v = &layouts[0]} }, //modified [Win]+[s], square mode
	{ Mod4Mask,                     XK_f,      setlayout,      {.v = &layouts[1]} }, //modified [Win]+[f], float mode
	{ Mod4Mask,                     XK_m,      setlayout,      {.v = &layouts[2]} }, //modified [Win]+[m], monocle mode
// 	{ Mod4Mask,                     XK_space,  setlayout,      {0} },                
// 	{ Mod4Mask,                     XK_space,  togglefloating, {0} },                //modified [Win]+[Space], toggle float for focused window
// 	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
// 	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
// 	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
// 	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
// 	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
// 	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
//  { MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },         //fullgaps
//  { MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },         //fullgaps
//  { MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },         //fullgaps
	TAGKEYS(                        XK_1,                      1)                    //argument column for 1st tag is actually 0
	TAGKEYS(                        XK_2,                      2)                    //but 1st tag is set to invisble unused tag
	TAGKEYS(                        XK_3,                      3)                    //so the first usable tag user sees is
	TAGKEYS(                        XK_4,                      4)                    //actually the 2nd tag in backend
	TAGKEYS(                        XK_5,                      5)                    //backend 1st tag is inaccessible to user
	TAGKEYS(                        XK_6,                      6)
	TAGKEYS(                        XK_7,                      7)
	TAGKEYS(                        XK_8,                      8)
	TAGKEYS(                        XK_9,                      9)
	{ Mod4Mask,                XK_Escape,      quit,           {0} },                //modified [Win]+[Esc], kill dwm
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },                //[LClick], click on mode icon to switch
// 	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
// 	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
// 	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         Mod4Mask,       Button1,        movemouse,      {0} },                //modified [Win]+[LClick], drag to move
// 	{ ClkClientWin,         Mod4Mask,       Button3,        togglefloating, {0} },
	{ ClkClientWin,         Mod4Mask,       Button3,        resizemouse,    {0} },                //modified [Win]+[RClick], drag to resize
	{ ClkTagBar,            0,              Button1,        view,           {0} },                //[LClick], click to select tag
// 	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
// 	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
// 	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

