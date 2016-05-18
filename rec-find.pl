#!/usr/bin/perl -w

use strict;
use warnings;
use File::Copy;
use 5.010;
use Getopt::Std;
use Getopt::Long;


	#our $numri = "23";
	#our $server = "5";
	#my $help = "";
	#GetOptions( 'rec|r' => \$numri,
	#			'server|s' => \$server,
	#	);
	#print $numri;
	#print $server;
	
	my %options =();
	getopts("hr:s:", \%options);

	if($options{h})
	{
		show_help();
		exit;
	}

	if($options{r} && !$options{s})
	{
		find_rec_local();
		exit;
	}


	#kontrollo nqs eshte dhen numri
	#if ($numri eq "" or $#ARGV == -1){
	#	die("Error : duhet dhene rec qe do kerkohet,perdor rec-find -h per me shume.\n")
	#}

	sub show_help 
	{

		print "\n Usage : \n";
		print "\n options : \n";
		print "\n -h : show Help \n";
		print "\n -r : rec-find -r 0000000 , rregistrimi qe do kerkohet,duhet te jepet vetem nje rregistrim..\n";
		print "\n -s : rec-find -r 0000000 -s 192.168.1.1 , serveri ku do kerkohet rregjistrimi, nqs nuk jepet kerkohet lokalisht.\n";
	}



	sub find_rec_local
	{
		my $numri =;
		GetOptions('r' => \$numri) or die "nuk eci vlla";
		#print $numri;
		#my $num_args = $#ARGV +1;
		#if ($num_args != 1){
		#	print "Error : Numer jo i sakte i argumenteve, perdor rec_find -h\n";
		#	exit;
		#}
		#print $numri;
		#exit;
		my $read = $numri;
		my $comand = "locate $read";
		my @location = `$comand`;

		chomp @location;

		my $num_lines = $#location +1;
		if ($num_lines == 0){
			print "Nuk u gjet asnje rregistrim.\n";
			exit;
		}

		foreach my $line (@location)
		{
			copy("$line", '/public/it-software/Rigert/rec')
		}
	}




