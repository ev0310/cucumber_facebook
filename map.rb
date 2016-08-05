my_hash = {'id' => '123', 'name' => 'igor'}

changed = my_hash.map do |k,v|
  if k == 'id'
    [k, "#{v[0]}"]
  else
    [k,v]
  end

end

p changed.to_h


 a = [["read_stream"], ["publish_actions"], ["user_posts"]]
 b = [["user_photos"]]
p a + b