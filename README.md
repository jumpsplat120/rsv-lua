# rsv-lua
 RSV implemented in nearly pure lua.

RSV is a simple binary alternative created by Stenway on Youtube. A video explaining the format can be found (here)[https://www.youtube.com/watch?v=tb_70o6ohMA].

While the RSV-Challenge repository does contain a lua implementation, it does not utilize the lua library UTF8, causing it to be a little more complicated than needs be. It also includes example code within the module, which means you'd have to modify it to actually be usable.

This library creates a simple rsv module that can be imported, and contains two functions; `encode` and `decode`. They work as expected, and will encode a 2D table into an RSV format (which will be a string), or takes a string, and decodes it into a 2D table. Loading from files is not within the scope of the parser, and so can be handled as per your perogative.
