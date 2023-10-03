sub collect_stat {
	my $stat = "/proc/stat".IO.slurp;
	my @cpus = $stat ~~ m:g/^^cpu.*?$$/;
	
	my @cpu_times = [];
	for @cpus -> $cpu {
		# get each columns digit and convert it to an integer
		@cpu_times.push: ($cpu ~~ m:g/<|w>\d+<|w>/)>>.Int;
	}
	
	return @cpu_times;
}

sub MAIN(
	Rat $interval = 0.5, #= interval between stat queries
) {
	my $stat0 = start collect_stat;
	sleep $interval;
	my $stat1 = start collect_stat;

	my @res = await $stat0, $stat1;

	sub calc_deltas(@end, @start) {
		return @end >>-<< @start;
	}

	my @usages = [];
	for 0..^@res[0].elems -> $i {
		my @deltas = (@res[1][$i] >>-<< @res[0][$i]).Array;
		@usages.push: 1-@deltas[3]/[+] @deltas;
	}

	@usages.join("\n").say;
}
