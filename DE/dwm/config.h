/* See LICENSE file for copyright and license details. */

void fibonacci(Monitor*, int);
void spiral(Monitor*);

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Anonymous Pro:size=13" }; //{ "Source Code Pro:size=11", "fontawesome:size=11" }; // { "Anonymous Pro:size=13" }; /
static const char dmenufont[]       = { "Anonymous Pro:size=13" };
static const char col_gray1[]       = "#222222";	//222222 - default //black
static const char col_gray2[]       = "#444444";	//444444 - default //light-gray
static const char col_gray3[]       = "#e8f6f7";	//bbbbbb - default //light-blue
static const char col_gray4[]       = "#302a36";	//eeeeee - default //gray
static const char col_cyan[]        = "#1177aa";	//005577 - default //cyan
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray3, col_cyan,  col_cyan  },
};

/* tagging */
/*
 *  ⌨   
 *   
 *   
 * ☕
 *  
 * ⌘   
 */
/*          */
/*  */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class		instance		title	tags mask	isfloating   monitor */
	{ "firefox",		NULL,		NULL,	1 << 3,		0,	-1 },
	{ "Luakit",			NULL,		NULL,	1 << 2,		0,	-1 },
	{ "st-256color",	NULL,		NULL,	1 << 1,		0,	-1 },
	{ "IDE",			NULL,		NULL,	1 << 0,		0,	-1 },
	{ "mpc",			NULL,		NULL,	1 << 5,		0,	-1 },
	{ "Zathura",		NULL,		NULL,	1 << 5,		0,	-1 },
	{ "TelegramDesktop",NULL,		NULL,	1 << 4,		0,	-1 },
	{ "whatsdesk",		NULL,		NULL,	1 << 4,		0,	-1 },
	{ "zoom",			"zoom",		NULL,	1 << 4,		0,	-1 },
	/* class		instance		title	tags mask	fl	mon	  //float x,y,w,h	floatborderpx*/
	{ "float",			NULL,		NULL,	0,			1,	-1 }, //	50,50,500,500,	1 },
	{ "Thunderbird",	NULL,		NULL,	1 << 4,		1,	-1 }, //	50,50,500,500,	1 },
	{ "KeePass2",		NULL,		NULL,	0,			1,	-1 }, //	50,50,500,500,	1 },
	{ "Steam",			NULL,		NULL,	1 << 7,		1,	-1 }, //	50,50,500,500,	1 },
	{ NULL,				NULL,		"Steam",1 << 7,		1,	-1 }, //	50,50,500,500,	1 },
	{ "Gimp",			NULL,		NULL,	1 << 6,		1,	-1 }, //	50,50,500,500,	1 },
	{ "Sxiv",			NULL,		NULL,	0,			1,	-1 }, //	50,50,500,500,	1 },
	{ "mpv",			NULL,		NULL,	0,			1,	-1 }, //	50,50,500,500,	1 },
	{ "discord",		NULL,		NULL,	1 << 4,		1,	-1 }, //	50,50,500,500,	1 },
	/* libreoffice */
	{ "libreoffice",	NULL,		NULL,	1 << 6,		0,	-1 }, //	50,50,500,500,	1 },
	{ NULL,			"libreoffice",	NULL,	1 << 6,		0,	-1 }, //	50,50,500,500,	1 },
	{ NULL,				NULL,"LibreOffice", 1 << 6,		0,	-1 }, //	50,50,500,500,	1 },
	{ "Soffice",		NULL,		NULL,	1 << 6,		0,	-1 }, //	50,50,500,500,	1 },
	/*    */
};

/* layout(s) */
static const float mfact     = 0.5;   /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;     /* number of clients in master area */
static const int resizehints = 1;     /* 1 means respect size hints in tiled resizals */
static const int attachdirection = 5; /* 0 default, 1 above, 2 aside, 3 below, 4 bottom, 5 top */ 

/*
 *   
 */
static const Layout layouts[] = {
	/* symbol	arrange function */
	{ "▏ Tile",	tile },
	{ "▏ Spiral",	spiral },	/* first entry is default */
	{ "▏ Float",	NULL },		/* no layout function means floating behavior */
	{ " ",	monocle },
};

/* Cool autostart */
static const char *const autostart[] = {
		"compton",	"--config",	"/home/xewii/.config/compton.conf",	NULL,
		"sh", "-c", "/home/xewii/.fehbg", NULL,
		"st", "-c", "IDE", "-e", "vim", NULL,
		"st", "-c", "mpc", "-e", "ncmpcpp",	NULL,
		"st", NULL,
		"st", NULL,
		"st", NULL,
		"st", NULL,
		"dunst", NULL,
		"notmon", NULL,
		"xbanish", NULL,
		"autocutsel", NULL,
		"autocutsel", "-selection", "PRIMARY", NULL,
		"clipmenud", NULL,
		"slstatus",	NULL,
		"telegram-desktop", NULL,
		"firefox", NULL,
		"luakit", NULL,
		NULL
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]    = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *nm_dmenucmd[] = { "networkmanager_dmenu", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *passmenucmd[] = { "passmenu2", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *clipmenucmd[] = { "clipmenu", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *mpdmenucmd[]  = { "mpdmenu",  "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *translcmd[]   = { "dmenu_trans",  "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };

/* terminal */
static const char *termcmd[]     = { "st", NULL };
/* system volume ctrl */
static const char *volume_upcmd[]     = { "amixer", "set", "Master", "5%+", NULL };
static const char *volume_downcmd[]   = { "amixer", "set", "Master", "5%-", NULL };
static const char *volume_togglecmd[] = { "amixer", "set", "Master", "toggle", NULL };

/* screenshots */
static const char *scrotcmd[]  = { "scrot", "%Y.%m.%d-%H:%M:%S_$wx$h.png", "-e", "mv $f ~/screenshots" , NULL };
static const char *scrotfcmd[] = { "scrot", "%Y.%m.%d-%H:%M:%S_$wx$h.png", "-u", "-e", "mv $f ~/screenshots" , NULL };

#include "mpdcontrol.c"
#include "movestack.c"
static Key keys[] = {
	/* modifier                     key				function	argument */
	/* { NULL,     	    			XF86XK_AudioNext,	    	mpd_switch_track,	{.i = -1 } }, */
	{ MODKEY|ShiftMask,    			XK_n,	    				mpd_switch_track,	{.i = -1 } },
	{ NULL,				            XF86XK_AudioPrev,	    	mpd_switch_track,	{.i = +1 } },
	{ MODKEY,		            	XF86XK_AudioRaiseVolume,	mpd_volume_ctl,		{.i = +1 } },
	{ MODKEY,              			XF86XK_AudioLowerVolume,	mpd_volume_ctl,		{.i = -1 } },
	{ NULL,				            XF86XK_AudioPlay,	    	mpd_switch_playback,	{0} },
	{ NULL,              			XF86XK_AudioRaiseVolume,	spawn,		{.v = volume_upcmd } },
	{ NULL,              			XF86XK_AudioLowerVolume,	spawn,		{.v = volume_downcmd } },
	{ NULL,              			XF86XK_AudioMute,			spawn,		{.v = volume_togglecmd } },
	{ NULL,	            			XK_Print,			spawn,			{.v = scrotcmd } },
	{ MODKEY,	           			XK_Print,			spawn,			{.v = scrotfcmd } },
	{ MODKEY,           			XK_n,			    spawn,			{.v = nm_dmenucmd } },
	{ MODKEY,                       XK_p,				spawn,			{.v = dmenucmd } },
	{ MODKEY,                       XK_c,				spawn,			{.v = clipmenucmd } },
	{ MODKEY|ShiftMask,     		XK_m,				spawn,			{.v = mpdmenucmd } },
	{ MODKEY|ShiftMask,	        	XK_p,				spawn,			{.v = passmenucmd } },
	{ MODKEY|ShiftMask,	        	XK_t,				spawn,			{.v = translcmd } },
	{ MODKEY|ShiftMask,             XK_Return,			spawn,			{.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
	{ MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
	{ MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,						XK_m,	   setlayout,	   {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

void
fibonacci(Monitor *mon, int s) {
	unsigned int i, n, nx, ny, nw, nh;
	Client *c;

	for(n = 0, c = nexttiled(mon->clients); c; c = nexttiled(c->next), n++);
	if(n == 0)
		return;
	
	nx = mon->wx;
	ny = 0;
	nw = mon->ww;
	nh = mon->wh;
	
	for(i = 0, c = nexttiled(mon->clients); c; c = nexttiled(c->next)) {
		if((i % 2 && nh / 2 > 2 * c->bw)
		   || (!(i % 2) && nw / 2 > 2 * c->bw)) {
			if(i < n - 1) {
				if(i % 2)
					nh /= 2;
				else
					nw /= 2;
				if((i % 4) == 2 && !s)
					nx += nw;
				else if((i % 4) == 3 && !s)
					ny += nh;
			}
			if((i % 4) == 0) {
				if(s)
					ny += nh;
				else
					ny -= nh;
			}
			else if((i % 4) == 1)
				nx += nw;
			else if((i % 4) == 2)
				ny += nh;
			else if((i % 4) == 3) {
				if(s)
					nx += nw;
				else
					nx -= nw;
			}
			if(i == 0)
			{
				if(n != 1)
					nw = mon->ww * mon->mfact;
				ny = mon->wy;
			}
			else if(i == 1)
				nw = mon->ww - nw;
			i++;
		}
		resize(c, nx, ny, nw - 2 * c->bw, nh - 2 * c->bw, False);
	}
}

void
spiral(Monitor *mon) {
	fibonacci(mon, 0);
}
