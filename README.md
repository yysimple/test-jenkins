#user  nobody;
worker_processes  1;
 
#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;
 
#pid        logs/nginx.pid;
 
 
events {
    worker_connections  1024;
}
 
 
http {
    include       mime.types;
    default_type  application/octet-stream;

 
    sendfile        on;
    #tcp_nopush     on;
 
    #keepalive_timeout  0;
    keepalive_timeout  65;
 
    #gzip  on;
 
    server {
        listen       80;
        server_name  localhost;
 
         # 接口代理配置
          location /prod-api/ {
           # 修改此处目标域名
          proxy_pass http://192.168.31.110:30790/;
          proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
          proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
          proxy_max_temp_file_size 0;
          proxy_connect_timeout      90;
          proxy_send_timeout         90;
          proxy_read_timeout         90;
          proxy_buffer_size          4k;
          proxy_buffers              4 32k;
          proxy_busy_buffers_size    64k;
          proxy_temp_file_write_size 64k;
    }
 
        location / {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
        }
 
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
}