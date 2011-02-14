def fibonacci(x)
	if x<=1
		return x
	else
		f1 = 1
		f2 = 1
		z = 0
		for i in 2..x
			temp = f1
			f1 = f2
			f2 = f2 + temp
		end
		return f1
	end
end

puts fibonacci(10)
