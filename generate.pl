#!/usr/bin/perl

my $templateDir = "templates";
my $targetDir = "../eBucksServiceProxy/src/main/java/com/ebucks";

while ($line = <dat/*>) {
    my $source = $line;
    my $target = $source;
    $target =~ s/dat\///;
    $target =~ s/Operations//;
    $target =~ s/\.java//;
    $qualifier = $target;
    $qualifier =~ s/SO//g;

    print "cw $templateDir soapserver.ftl $source $targetDir/soap/${target}WS.java\n";
    print "cw $templateDir soapqualifier.ftl $source $targetDir/corba/client/${qualifier}Qualifier.java\n";
    print "cw $templateDir soapfactory.ftl $source $targetDir/corba/client/${target}Factory.java\n";

}
