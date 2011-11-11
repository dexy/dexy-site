%%{
  machine hello_and_welcome;
  main := ( 'h' @ { puts "hello world!" } 
          | 'w' @ { puts "welcome" }
          )*;
}%%
  data = 'whwwwwhw'
  %% write data;
  %% write init;
  %% write exec;
  