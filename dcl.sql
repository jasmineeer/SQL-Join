-- membuat user --
create user 'jasmine_xir4'@'localhost' identified by 'jasmineer';

-- mengubah hak akses -- 
grant all privileges on *.* to 'jasmine_xir4'@'localhost';

flush privileges;

grant drop, create on *.* to 'jasmine_xir4'@'localhost';

-- mencabut hak akses -- 
revoke all privileges on *.* from 'jasmine_xir4'@'localhost';

-- menghapus -- 
drop user 'jasmine_xir4'@'localhost';