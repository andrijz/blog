# sample keyspace 
create keyspace if not exists blog with replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

# edge connection table to play a role of a closure table
create table if not exists blog.edge_connection(
    device_ancestor_id text,
    session_id text,
    distance int,
    device_descendant_id text,
    primary key ((device_ancestor_id, session_id), distance, device_descendant_id)
) with clustering order by (distance asc, device_descendant_id asc);

# insert sample data
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('A', 'A', 0, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('A', 'B', 1, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('A', 'C', 2, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('A', 'D', 1, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('A', 'E', 2, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('A', 'G', 2, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('A', 'F', 3, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('A', 'H', 1, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('B', 'B', 0, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('B', 'C', 1, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('C', 'C', 0, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('D', 'D', 0, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('D', 'E', 1, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('D', 'F', 2, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('D', 'G', 1, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('E', 'E', 0, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('E', 'F', 1, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('F', 'F', 0, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('G', 'G', 0, 'sessionX');
insert into blog.edge_connection(device_ancestor_id, device_descendant_id, distance, session_id) values('H', 'H', 0, 'sessionX');

# querying all subordinates:
select device_descendant_id from blog.edge_connection where device_ancestor_id = 'D' and session_id = 'sessionX';

# querying all subordinates with limited distance:
select device_descendant_id from blog.edge_connection where device_ancestor_id = 'D' and session_id = 'sessionX' and distance <=1;
