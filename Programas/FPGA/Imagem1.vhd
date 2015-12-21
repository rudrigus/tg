library ieee;
use work.Common.all;


ENTITY Imagem1 IS
	PORT (imagem : out matriz_imagem);
END Imagem1;


ARCHITECTURE padrao of Imagem1 IS
	
	constant imagem_padrao : matriz_imagem := ((X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"49", X"52", X"52", X"52", X"5B", X"5B", X"52", X"52", X"49", X"52", X"00", X"49", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"9B", X"A4", X"F7", X"07", X"F7", X"07", X"07", X"07", X"F7", X"A4", X"A4", X"F7", X"F7", X"F7", X"A4", X"5B", X"52", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"A4", X"A4", X"A4", X"A4", X"F7", X"07", X"F6", X"FF", X"FF", X"F6", X"07", X"F7", X"F7", X"A4", X"9B", X"A4", X"A4", X"9B", X"9B", X"5B", X"5B", X"5B", X"5B", X"52", X"49", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"A4", X"A4", X"9B", X"9B", X"A4", X"F7", X"F7", X"07", X"07", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"08", X"07", X"F7", X"F7", X"A4", X"A4", X"F7", X"A4", X"A4", X"A4", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"9B", X"9B", X"A4", X"A4", X"F7", X"07", X"07", X"08", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"07", X"07", X"F7", X"07", X"07", X"F7", X"F7", X"A4", X"A4", X"A4", X"9B", X"9B", X"5B", X"52", X"9B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"9B", X"5B", X"9B", X"A4", X"F7", X"F7", X"07", X"07", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"F6", X"08", X"07", X"08", X"07", X"F7", X"F7", X"F7", X"A4", X"9B", X"9B", X"9B", X"9B", X"5B", X"5B", X"52", X"49", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"A4", X"5B", X"A4", X"A4", X"F7", X"07", X"07", X"08", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"F6", X"F6", X"08", X"07", X"07", X"F7", X"F7", X"A4", X"A4", X"A4", X"A4", X"5B", X"9B", X"9B", X"9B", X"49", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"A4", X"5B", X"A4", X"F7", X"07", X"07", X"08", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"07", X"07", X"07", X"07", X"F7", X"F7", X"A4", X"9B", X"A4", X"9B", X"A4", X"52", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"F7", X"A4", X"9B", X"A4", X"F7", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"FF", X"F6", X"F6", X"F6", X"08", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"FF", X"F6", X"08", X"08", X"07", X"07", X"F7", X"A4", X"A4", X"A4", X"A4", X"A4", X"9B", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"A4", X"A4", X"A4", X"A4", X"A4", X"F7", X"07", X"08", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"F6", X"08", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"08", X"07", X"07", X"F7", X"A4", X"A4", X"A4", X"A4", X"A4", X"F7", X"49", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"A4", X"F7", X"A4", X"A4", X"F7", X"F7", X"07", X"07", X"08", X"08", X"F6", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"08", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"08", X"07", X"F7", X"F7", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"F7", X"49", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"07", X"A4", X"A4", X"A4", X"A4", X"F7", X"07", X"07", X"08", X"08", X"F6", X"F6", X"FF", X"FF", X"FF", X"FF", X"F6", X"FF", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"08", X"07", X"07", X"F7", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"F7", X"49", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"9B", X"F7", X"A4", X"A4", X"A4", X"A4", X"F7", X"07", X"07", X"08", X"F6", X"F6", X"F6", X"FF", X"FF", X"F6", X"F6", X"F6", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"08", X"07", X"07", X"F7", X"A4", X"F7", X"A4", X"A4", X"A4", X"9B", X"A4", X"49", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"A4", X"5B", X"9B", X"A4", X"A4", X"F7", X"F7", X"07", X"07", X"07", X"08", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"08", X"08", X"F6", X"F6", X"F6", X"08", X"08", X"08", X"07", X"07", X"07", X"F7", X"F7", X"F7", X"F7", X"A4", X"A4", X"A4", X"A4", X"52", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"F7", X"5B", X"9B", X"A4", X"F7", X"F7", X"F7", X"07", X"07", X"08", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"07", X"07", X"FF", X"07", X"FF", X"FF", X"08", X"08", X"08", X"F6", X"08", X"08", X"08", X"07", X"07", X"07", X"F7", X"F7", X"F7", X"A4", X"F7", X"A4", X"A4", X"5B", X"F7", X"5B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"F7", X"9B", X"9B", X"A4", X"A4", X"F7", X"07", X"07", X"08", X"F6", X"F6", X"F6", X"FF", X"F6", X"F6", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"FF", X"9B", X"5B", X"52", X"52", X"5B", X"F7", X"F6", X"07", X"08", X"07", X"07", X"07", X"07", X"07", X"07", X"F7", X"F7", X"F7", X"F7", X"F7", X"A4", X"A4", X"A4", X"9B", X"5B", X"F7", X"5B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"F7", X"9B", X"9B", X"9B", X"A4", X"F7", X"07", X"07", X"08", X"08", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"FF", X"FF", X"FF", X"F6", X"F6", X"FF", X"F7", X"52", X"49", X"49", X"49", X"52", X"52", X"08", X"07", X"07", X"07", X"07", X"07", X"F7", X"F7", X"F7", X"F7", X"F7", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"9B", X"5B", X"F7", X"5B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"A4", X"A4", X"A4", X"A4", X"A4", X"F7", X"07", X"07", X"07", X"07", X"07", X"08", X"08", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"F6", X"08", X"5B", X"49", X"00", X"00", X"00", X"49", X"49", X"07", X"07", X"07", X"07", X"07", X"F7", X"F7", X"F7", X"F7", X"F7", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"9B", X"5B", X"F7", X"9B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"A4", X"A4", X"A4", X"A4", X"F7", X"F7", X"F7", X"07", X"07", X"07", X"07", X"07", X"07", X"07", X"07", X"08", X"08", X"08", X"08", X"08", X"08", X"07", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"07", X"07", X"07", X"07", X"F7", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"F7", X"A4", X"A4", X"A4", X"A4", X"9B", X"5B", X"A4", X"5B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"A4", X"A4", X"A4", X"A4", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"07", X"07", X"07", X"07", X"07", X"07", X"07", X"07", X"07", X"F7", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"F7", X"F7", X"F7", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"5B", X"A4", X"5B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"A4", X"9B", X"A4", X"A4", X"F7", X"F7", X"F7", X"F7", X"F7", X"07", X"07", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"A4", X"9B", X"00", X"00", X"00", X"00", X"00", X"00", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"A4", X"A4", X"A4", X"9B", X"9B", X"5B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"A4", X"9B", X"9B", X"9B", X"A4", X"A4", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"F7", X"A4", X"F7", X"A4", X"A4", X"A4", X"A4", X"A4", X"9B", X"00", X"00", X"00", X"00", X"00", X"00", X"A4", X"A4", X"A4", X"9B", X"9B", X"A4", X"9B", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"9B", X"9B", X"9B", X"A4", X"9B", X"9B", X"9B", X"9B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"A4", X"9B", X"9B", X"9B", X"A4", X"A4", X"A4", X"F7", X"F7", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"9B", X"9B", X"9B", X"9B", X"5B", X"9B", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"9B", X"9B", X"5B", X"9B", X"9B", X"9B", X"9B", X"5B", X"9B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"9B", X"9B", X"9B", X"9B", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"9B", X"A4", X"9B", X"A4", X"9B", X"9B", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"5B", X"5B", X"5B", X"5B", X"5B", X"9B", X"9B", X"9B", X"9B", X"5B", X"9B", X"9B", X"9B", X"5B", X"5B", X"9B", X"9B", X"5B", X"9B", X"5B", X"A4", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"52", X"9B", X"9B", X"9B", X"9B", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"9B", X"9B", X"9B", X"A4", X"9B", X"5B", X"5B", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"5B", X"5B", X"9B", X"5B", X"5B", X"9B", X"9B", X"5B", X"5B", X"5B", X"9B", X"5B", X"5B", X"5B", X"5B", X"9B", X"5B", X"9B", X"5B", X"5B", X"5B", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"5B", X"9B", X"5B", X"5B", X"9B", X"9B", X"9B", X"A4", X"A4", X"A4", X"9B", X"9B", X"9B", X"5B", X"5B", X"9B", X"9B", X"9B", X"9B", X"5B", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"5B", X"5B", X"5B", X"9B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"9B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"9B", X"9B", X"9B", X"9B", X"9B", X"9B", X"9B", X"9B", X"A4", X"9B", X"9B", X"9B", X"5B", X"9B", X"9B", X"9B", X"9B", X"5B", X"52", X"5B", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"52", X"9B", X"5B", X"5B", X"5B", X"5B", X"9B", X"9B", X"9B", X"5B", X"9B", X"9B", X"9B", X"9B", X"5B", X"5B", X"5B", X"A4", X"5B", X"5B", X"5B", X"52", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"5B", X"9B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"52", X"52", X"5B", X"5B", X"5B", X"52", X"5B", X"5B", X"5B", X"49", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"52", X"A4", X"5B", X"9B", X"5B", X"9B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"9B", X"9B", X"5B", X"A4", X"9B", X"9B", X"5B", X"5B", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"52", X"5B", X"52", X"5B", X"5B", X"5B", X"5B", X"49", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"49", X"9B", X"5B", X"5B", X"5B", X"5B", X"5B", X"9B", X"9B", X"5B", X"5B", X"5B", X"5B", X"9B", X"5B", X"5B", X"9B", X"9B", X"52", X"5B", X"5B", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"5B", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"52", X"52", X"52", X"5B", X"52", X"5B", X"5B", X"5B", X"5B", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"9B", X"9B", X"5B", X"5B", X"5B", X"52", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"5B", X"52", X"52", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"5B", X"5B", X"52", X"52", X"5B", X"52", X"5B", X"5B", X"52", X"52", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"9B", X"5B", X"52", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"5B", X"52", X"52", X"5B", X"5B", X"5B", X"52", X"52", X"5B", X"5B", X"9B", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"5B", X"9B", X"5B", X"5B", X"52", X"52", X"5B", X"5B", X"52", X"52", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"49", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"5B", X"5B", X"5B", X"52", X"52", X"52", X"52", X"52", X"5B", X"5B", X"5B", X"52", X"52", X"5B", X"52", X"52", X"52", X"5B", X"5B", X"5B", X"9B", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"5B", X"5B", X"5B", X"5B", X"52", X"52", X"52", X"52", X"5B", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"5B", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"9B", X"5B", X"52", X"5B", X"52", X"52", X"5B", X"5B", X"5B", X"49", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"5B", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"5B", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"52", X"52", X"52", X"5B", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"5B", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"5B", X"5B", X"5B", X"5B", X"5B", X"52", X"52", X"52", X"52", X"5B", X"5B", X"52", X"5B", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"5B", X"5B", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"5B", X"52", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"5B", X"5B", X"5B", X"5B", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"52", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"5B", X"9B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"5B", X"A4", X"F7", X"A4", X"A4", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"5B", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"A4", X"F7", X"F7", X"A4", X"A4", X"A4", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"5B", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"F7", X"F7", X"A4", X"A4", X"A4", X"9B", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"52", X"52", X"52", X"5B", X"F7", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"49", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"9B", X"A4", X"A4", X"A4", X"9B", X"9B", X"9B", X"9B", X"5B", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"49", X"52", X"52", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"52", X"5B", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"9B", X"5B", X"5B", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"5B", X"A4", X"A4", X"A4", X"A4", X"9B", X"9B", X"9B", X"5B", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"5B", X"A4", X"A4", X"A4", X"A4", X"9B", X"5B", X"9B", X"5B", X"5B", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"52", X"52", X"52", X"49", X"52", X"52", X"52", X"5B", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"52", X"9B", X"5B", X"5B", X"9B", X"52", X"52", X"52", X"52", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"49", X"49", X"49", X"49", X"52", X"5B", X"52", X"52", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"49", X"00", X"49", X"49", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"),
(X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00"));

	
BEGIN
		imagem <= imagem_padrao;
END padrao;