function flexrealm_appletree(x, y, z, treedir, area, data, c_tree, c_leaves, c_apple)
	if treedir == 1 then
		for i = 0, 5 do
			if i >= 3 and i <= 5 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i + 1, y + j, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x + i, y, z)
			data[vit] = c_tree
		end
	elseif treedir == 2 then
		for i = 0, 5 do
			if i >= 3 and i <= 5 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x - i - 1, y + j, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x - i, y, z)
			data[vit] = c_tree
		end
	elseif treedir == 3 then
		for j = 0, 5 do
			if j >= 3 and j <= 5 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y + j + 1, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x, y + j, z)
			data[vit] = c_tree
		end
	elseif treedir == 4 then
		for j = 0, 5 do
			if j >= 3 and j <= 5 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y - j - 1, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x, y - j, z)
			data[vit] = c_tree
		end
	elseif treedir == 5 then
		for k = 0, 5 do
			if k >= 3 and k <= 5 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z + k + 1)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x, y, z + k)
			data[vit] = c_tree
		end
	elseif treedir == 6 then
		for k = 0, 5 do
			if k >= 3 and k <= 5 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z - k - 1)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x, y, z - k)
			data[vit] = c_tree
		end
	end
end

function flexrealm_pinetree(x, y, z, treedir, area, data, c_tree, c_flrneedles, c_snowblock)
	if treedir == 1 then
		for i = -2, 11 do
		for j = -1, 1 do
		for k = -1, 1 do
			local vi = area:index(x + i, y + j, z + k)
			if i >= 2 and i <= 4 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif i == 5 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				elseif j * k == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif i >= 6 and i <= 7 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				elseif j * k == 0 then
					data[vi] = c_flrneedles
				end
			elseif i == 8 then
				if j == 0 and k == 0 then
					data[vi] = c_flrneedles
				elseif j * k == 0 then
					data[vi] = c_snowblock
				end
			elseif j == 0 and k == 0 then
				if i <= 1 then
					data[vi] = c_tree
				elseif i == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 2 then
		for i = -2, 11 do
		for j = -1, 1 do
		for k = -1, 1 do
			local vi = area:index(x - i, y + j, z + k)
			if i >= 2 and i <= 4 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif i == 5 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				elseif j * k == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif i >= 6 and i <= 7 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				elseif j * k == 0 then
					data[vi] = c_flrneedles
				end
			elseif i == 8 then
				if j == 0 and k == 0 then
					data[vi] = c_flrneedles
				elseif j * k == 0 then
					data[vi] = c_snowblock
				end
			elseif j == 0 and k == 0 then
				if i <= 1 then
					data[vi] = c_tree
				elseif i == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 3 then
		for j = -2, 11 do
		for i = -1, 1 do
		for k = -1, 1 do
			local vi = area:index(x + i, y + j, z + k)
			if j >= 2 and j <= 4 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif j == 5 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				elseif i * k == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif j >= 6 and j <= 7 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				elseif i * k == 0 then
					data[vi] = c_flrneedles
				end
			elseif j == 8 then
				if i == 0 and k == 0 then
					data[vi] = c_flrneedles
				elseif i * k == 0 then
					data[vi] = c_snowblock
				end
			elseif i == 0 and k == 0 then
				if j <= 1 then
					data[vi] = c_tree
				elseif j == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 4 then
		for j = -2, 11 do
		for i = -1, 1 do
		for k = -1, 1 do
			local vi = area:index(x + i, y - j, z + k)
			if j >= 2 and j <= 4 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif j == 5 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				elseif i * k == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif j >= 6 and j <= 7 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				elseif i * k == 0 then
					data[vi] = c_flrneedles
				end
			elseif j == 8 then
				if i == 0 and k == 0 then
					data[vi] = c_flrneedles
				elseif i * k == 0 then
					data[vi] = c_snowblock
				end
			elseif i == 0 and k == 0 then
				if j <= 1 then
					data[vi] = c_tree
				elseif j == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 5 then
		for k = -2, 11 do
		for i = -1, 1 do
		for j = -1, 1 do
			local vi = area:index(x + i, y + j, z + k)
			if k >= 2 and k <= 4 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif k == 5 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				elseif i * j == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif k >= 6 and k <= 7 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				elseif i * j == 0 then
					data[vi] = c_flrneedles
				end
			elseif k == 8 then
				if i == 0 and j == 0 then
					data[vi] = c_flrneedles
				elseif i * j == 0 then
					data[vi] = c_snowblock
				end
			elseif i == 0 and j == 0 then
				if k <= 1 then
					data[vi] = c_tree
				elseif k == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 6 then
		for k = -2, 11 do
		for i = -1, 1 do
		for j = -1, 1 do
			local vi = area:index(x + i, y + j, z - k)
			if k >= 2 and k <= 4 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif k == 5 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				elseif i * j == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif k >= 6 and k <= 7 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				elseif i * j == 0 then
					data[vi] = c_flrneedles
				end
			elseif k == 8 then
				if i == 0 and j == 0 then
					data[vi] = c_flrneedles
				elseif i * j == 0 then
					data[vi] = c_snowblock
				end
			elseif i == 0 and j == 0 then
				if k <= 1 then
					data[vi] = c_tree
				elseif k == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	end
end

function flexrealm_savannatree(x, y, z, treedir, area, data, c_tree, c_flrsavleaf)
	if treedir == 1 then
		for i = 0, 6 do
			if i >= 5 then
				for j = -3, 3 do
				for k = -3, 3 do
					local vil = area:index(x + i + 1, y + j, z + k)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x + i, y, z)
			data[vit] = c_tree
		end
	elseif treedir == 2 then
		for i = 0, 6 do
			if i >= 5 then
				for j = -3, 3 do
				for k = -3, 3 do
					local vil = area:index(x - i - 1, y + j, z + k)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x - i, y, z)
			data[vit] = c_tree
		end
	elseif treedir == 3 then
		for j = 0, 6 do
			if j >= 5 then
				for i = -3, 3 do
				for k = -3, 3 do
					local vil = area:index(x + i, y + j + 1, z + k)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x, y + j, z)
			data[vit] = c_tree
		end
	elseif treedir == 4 then
		for j = 0, 6 do
			if j >= 5 then
				for i = -3, 3 do
				for k = -3, 3 do
					local vil = area:index(x + i, y - j - 1, z + k)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x, y - j, z)
			data[vit] = c_tree
		end
	elseif treedir == 5 then
		for k = 0, 6 do
			if k >= 5 then
				for i = -3, 3 do
				for j = -3, 3 do
					local vil = area:index(x + i, y + j, z + k + 1)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x, y, z + k)
			data[vit] = c_tree
		end
	elseif treedir == 6 then
		for k = 0, 6 do
			if k >= 5 then
				for i = -3, 3 do
				for j = -3, 3 do
					local vil = area:index(x + i, y + j, z - k - 1)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x, y, z - k)
			data[vit] = c_tree
		end
	end
end

function flexrealm_jungletree(x, y, z, treedir, area, data, c_juntree, c_flrjunleaf)
	if treedir == 1 then
		for i = -4, 17 do
			if i == 11 or i == 17 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i + math.random(0, 1), y + j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x + i, y, z)
			data[vit] = c_juntree
		end
	elseif treedir == 2 then
		for i = -4, 17 do
			if i == 11 or i == 17 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x - i - math.random(0, 1), y + j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x - i, y, z)
			data[vit] = c_juntree
		end
	elseif treedir == 3 then
		for j = -4, 17 do
			if j == 11 or j == 17 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x, y + j, z)
			data[vit] = c_juntree
		end
	elseif treedir == 4 then
		for j = -4, 17 do
			if j == 3 or j == 17 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y - j - math.random(0, 1), z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x, y - j, z)
			data[vit] = c_tree
		end
	elseif treedir == 5 then
		for k = -4, 17 do
			if k == 3 or k == 17 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z + k + math.random(0, 1))
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x, y, z + k)
			data[vit] = c_juntree
		end
	elseif treedir == 6 then
		for k = -4, 17 do
			if k == 11 or k == 17 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z - k - math.random(0, 1))
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x, y, z - k)
			data[vit] = c_juntree
		end
	end
end

function flexrealm_grass(x, y, z, treedir, area, data, c_grass, vi)
	if treedir == 1 then
		data[vi + 1] = c_grass
	elseif treedir == 2 then
		data[vi - 1] = c_grass
	elseif treedir == 3 then	
		local via = area:index(x , y + 1, z)
		data[via] = c_grass
	elseif treedir == 4 then
		local via = area:index(x , y - 1, z)
		data[via] = c_grass
	elseif treedir == 5 then
		local via = area:index(x , y , z + 1)
		data[via] = c_grass
	elseif treedir == 6 then
		local via = area:index(x , y , z - 1)
		data[via] = c_grass
	end
end


function flexrealm_dryshrub(x, y, z, treedir, area, data, c_dryshrub, vi)
	if treedir == 1 then
		data[vi + 1] = c_dryshrub
	elseif treedir == 2 then
		data[vi - 1] = c_dryshrub
	elseif treedir == 3 then	
		local via = area:index(x , y + 1, z)
		data[via] = c_dryshrub
	elseif treedir == 4 then
		local via = area:index(x , y - 1, z)
		data[via] = c_dryshrub
	elseif treedir == 5 then
		local via = area:index(x , y , z + 1)
		data[via] = c_dryshrub
	elseif treedir == 6 then
		local via = area:index(x , y , z - 1)
		data[via] = c_dryshrub
	end
end

function flexrealm_jungrass(x, y, z, treedir, area, data, c_jungrass, vi)
	if treedir == 1 then
		data[vi + 1] = c_jungrass
	elseif treedir == 2 then
		data[vi - 1] = c_jungrass
	elseif treedir == 3 then	
		local via = area:index(x , y + 1, z)
		data[via] = c_jungrass
	elseif treedir == 4 then
		local via = area:index(x , y - 1, z)
		data[via] = c_jungrass
	elseif treedir == 5 then
		local via = area:index(x , y , z + 1)
		data[via] = c_jungrass
	elseif treedir == 6 then
		local via = area:index(x , y , z - 1)
		data[via] = c_jungrass
	end
end