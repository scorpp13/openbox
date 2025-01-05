#!/usr/bin/env python
import gi; gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk
from functools import reduce
import sys, os, re




Colors = {
	'AB' : { 'Name' : 'Active Back', 'Default' : '#579c8e' },
	'AF' : { 'Name' : 'Active Fore', 'Default' : '#ffffff' },
	'AL' : { 'Name' : 'Active Line', 'Default' : '#292929' },
	'NB' : { 'Name' : 'Normal Back', 'Default' : '#383838' },
	'NF' : { 'Name' : 'Normal Fore', 'Default' : '#dadada' },
	'NL' : { 'Name' : 'Normal Line', 'Default' : '#292929' },
}

Options = {
	'B?' : { 'Name' : 'Borders',       'Default' : True  },
	'H?' : { 'Name' : 'Active Handle', 'Default' : False },
	'G?' : { 'Name' : 'Gradients',     'Default' : False },
	'R?' : { 'Name' : 'Raised',        'Default' : False },
}




def Init (l):
	for r in l.values():
		r['Initial'] = r['Value'] = r['Default']

Init(Colors)
Init(Options)




Dir = os.path.dirname(os.path.realpath(sys.argv[0]))
InPath = Dir + '/themerc.in'
OutPath = Dir + '/themerc'




def InitV (k, vs, f, s):
	if k in vs: vs[k]['Initial'] = vs[k]['Value'] = f(s)

with open(Dir + '/themerc') as f:
	for l in f.readlines():
		
		if l[0] != '#': continue
		ss = l.strip().split(' ')
		k, v = ss[0].lstrip('#'), ss[1]
		
		InitV(k, Colors, lambda s: s, v)
		InitV(k, Options, lambda s: (v == 'True'), v)




def Read (path):
	with open(path) as f:
		return f.read()




def Rgb8 (c):
	return [int(c[i:i+2], 16) for i in (1, 3, 5)]

def Hex8FromRgb8 (c):
	return '#%02x%02x%02x' % tuple(c)

def Hex8FromRgb (c):
	return Hex8FromRgb8 (
		map(lambda f: int(f * 0xFF), c)
	)




def Subst (src, op, cl, fun):
	
	s = src.split(op)
	o = s[0]
	
	for si in range(1, len(s)):
		b = s[si].split(cl)
		o = o + fun(b[0]) + b[1]
	
	return o


def SubstCond (s):

	kv = s.split(' ', 1)
	yn = kv[1].split('!')
	
	return yn[0] if Options[kv[0]]['Value'] else yn[1]


def SubstColor (s):
	
	def pone (c):
		if (c.startswith('#')): return Rgb8(c)
		else: return Rgb8(Colors[c]['Value'])
	
	def addc (a, b):
		return map(lambda c0, c1: c0 + c1, a, b)
	
	def divc (c, d):
		return map(lambda c: int(c / d), c)
	
	cs = [pone(c) for c in s.split(' ')];
	return Hex8FromRgb8(divc(reduce(addc, cs), len(cs)))


def ExVals (vs):
	return '\n'.join (
		map (
			lambda k: '#' + k + ' ' + str(vs[k]['Value']), vs
		)
	) + '\n'


def Apply ():
	
	s = Read(InPath)
	
	s = Subst(s, '[', ']', SubstCond)
	s = Subst(s, '{', '}', SubstColor)
	
	s = ExVals(Colors) + ExVals(Options) + '\n' + s
	
	with open(OutPath, 'w') as of: of.write(s)
	os.system('openbox --reconfigure')


def Reveal ():
	for c in Colors.values():
		c['Button'].set_color(Gdk.color_parse(c['Value']))
	for o in Options.values():
		o['Switch'].set_state(o['Value'])


def Reset (key):
	for c in list(Colors.values()) + list(Options.values()):
		c['Value'] = c[key]
	Reveal()


def FromGtk ():
	
	m = Gtk.Menu()
	i = Gtk.MenuItem()
	w = Gtk.Window()
	m.add(i)
	
	ms = m.get_style_context()
	rs = i.get_style_context()
	ws = w.get_style_context()
	
	def ccc (key, gc):
		Colors[key]['Value'] = Hex8FromRgb([gc.red, gc.green, gc.blue])
	
	ccc('AB', rs.get_background_color(Gtk.StateFlags.PRELIGHT))
	ccc('AF', rs.get_color(Gtk.StateFlags.PRELIGHT))
	ccc('AL', ms.get_border_color(Gtk.StateFlags.PRELIGHT))
	ccc('NB', ws.get_background_color(Gtk.StateFlags.NORMAL))
	ccc('NF', ws.get_color(Gtk.StateFlags.NORMAL))
	ccc('NL', ms.get_border_color(Gtk.StateFlags.NORMAL))
	
	Reveal()





W = Gtk.Window(title = "Lean OB")
W.set_icon_name("applications-graphics")
W.connect("destroy", lambda e: Gtk.main_quit())
W.set_resizable(False)
W.set_border_width(8)

T = Gtk.Grid()
T.set_row_spacing(4)
T.set_column_spacing(4)
T.Rows = 0

def AddRow (t, label, o):
	t.attach(Gtk.Label(label + ':'), 0, t.Rows, 1, 1)
	t.attach(o, 1, T.Rows, 1, 1)
	t.Rows = t.Rows + 1

def SetC (ck, c):
	Colors[ck]['Value'] = Hex8FromRgb(c.to_floats())

def SetO (ok, o):
	Options[ok]['Value'] = o

for ck in sorted(Colors):
	c = Colors[ck]
	cbtn = c['Button'] = Gtk.ColorButton(color = Gdk.color_parse(c['Value']))
	cbtn.connect('color-set', lambda b, k: SetC(k, b.get_color()), ck)
	AddRow(T, c['Name'], cbtn)

for ok in sorted(Options):
	o = Options[ok]
	osw = o['Switch'] = Gtk.Switch(state = o['Value'])
	osw.connect('state-set', lambda s, v, k: SetO(k, v), ok)
	AddRow(T, o['Name'], osw)

DefaultBtn = Gtk.Button("Default")
RevertBtn = Gtk.Button("Revert")
FromGtkBtn = Gtk.Button("From GTK")
ApplyBtn = Gtk.Button("Apply")

DefaultBtn.connect('clicked', lambda e: Reset('Default'))
RevertBtn.connect('clicked', lambda e: Reset('Initial'))
FromGtkBtn.connect('clicked', lambda e: FromGtk())
ApplyBtn.connect('clicked', lambda e: Apply())

V = Gtk.VBox(spacing = 8)
V.pack_start(DefaultBtn, True, True, 0)
V.pack_start(FromGtkBtn, True, True, 0)
V.pack_start(T, True, True, 0)
V.pack_start(RevertBtn, True, True, 0)
V.pack_start(ApplyBtn, True, True, 0)
W.add(V)

W.show_all()
Gtk.main()
