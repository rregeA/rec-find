#!/usr/bin/perl -w

use strict;
use warnings;
use File::Copy;
use 5.010;
use Getopt::Std;
use Net::OpenSSH;


	
	my %options =();
	getopts("h:r:s:", \%options);

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

	if($options{r} && $options{s})
	{
		find_rec_server();
		exit;
	}

	if(!$options{r})
	{
		print "Error : Duhet dhene numri i rregistrimit qe do kerkohet, shiko rec-find -h per me shume.\n";
	}



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
		
		my $numri = $options{r};
		my $comand = "locate $numri";
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

	sub find_rec_server
	{
				print "kodi per serverat sipe.\n";
				my $host = $options{s};
				my $host_plote = "root@"."$host";
				my @keyfile = ("/root/.ssh/id_rsa");
				
				my $numri = $options{r};
		        
		        my $cmd = "locate $numri";

				
				my $ssh = Net::OpenSSH->new($host_plote);


				
				my @location = $ssh->capture("locate $numri");
				chomp @location;

				my $num_lines = $#location +1;
					if ($num_lines == 0){
						print "Nuk u gjet asnje rregistrim.\n";
						exit;
					}
				foreach my $line (@location)
					{
						
						$ssh->system("scp $line arch:/public/it-software/Rigert/rec");
					}
				
	}






