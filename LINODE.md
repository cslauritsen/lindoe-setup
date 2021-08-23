# Fail2Ban
Use [linode's instructions to install fail2ban](https://www.linode.com/docs/guides/how-to-use-fail2ban-for-ssh-brute-force-protection/).

## DROP instead of REJECT
Optional: update the ban rule to iptables' `DROP` instead of `REJECT`. This saves you on outoing bandwidth, and wastes attackers' resources too. Add the following content to `/etc/fail2ban/action.d/`:

```
[Init]

# Option:  blocktype
# Note:    This is what the action does with rules. This can be any jump target
#          as per the iptables man page (section 8). Common values are DROP
#          REJECT, REJECT --reject-with icmp-port-unreachable
# Values:  STRING
#blocktype = REJECT --reject-with icmp-port-unreachable
# csl 23-aug-2021 drop is better, imo
blocktype = DROP


[Init?family=inet6]

# Option:  blocktype (ipv6)
# Note:    This is what the action does with rules. This can be any jump target
#          as per the iptables man page (section 8). Common values are DROP
#          REJECT, REJECT --reject-with icmp6-port-unreachable
# Values:  STRING
#blocktype = REJECT --reject-with icmp6-port-unreachable
blocktype = DROP
```

