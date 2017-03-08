%VAPP is the Berkeley Verilog-A Parser and Processor, a sub-project of
%MAPP, the Berkeley Model and Algorithm Prototyping Platform.
%
%VAPP translates Verilog-A models into ModSpec, a general-purpose, standalone,
%low-level, executable model specification format for multi-physics (not just
%electrical) devices. ModSpec is currently supported by MAPP, as well as
%Sandia's simulator Xyce. ModSpec was designed specifically to facilitate the
%description of devices in a mathematically and physically well posed manner.
%
%Unlike ModSpec, Verilog-A was not designed for device modelling specifically,
%but is a general analog/mixed-signal (AMS) modelling and simulation language.
%As a result, it provides facilities that are not appropriate for defining
%well-posed and robust device models. VAPP disallows a number of (from a device
%modelling perspective) dangerous, confusing or unnecessary Verilog-A constructs
%in an attempt to address this problem.
%
%
%See also
%--------
%VAPPquickstart, VAPPexamples, va2modspec

help aboutVAPP;
