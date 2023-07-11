# cloudflare-dyndns
A short script for updating Cloudflare DNS entries using their api.

<br>This script uses the public Cloudflare API to update EXISTING A entries with your current public IP.
<br>It basically allows you to use the cloudflare DNS System as an alternative to existing Dyndns providers like dyndns.org or noip.com.

<br>You have to insert the E-Mail Address of your cloudflare Account, your Global API Key and the Full Domain you want to update.
<br>You also have to make sure that the dns entry (which has to be an A entry) already exists, otherwise the script will fail.

<br>It is also required to have jq installed on your machine.
<br>You can get it here: https://stedolan.github.io/jq/
<br>Make sure that the variable JQ points to the jq-linux64 executable and that you have execution rights for jq-linux64.



<br>This is the first ever script i published online and I'm aware that it is neither professionally done nor user friendly in any way.
<br>I was just making my own script because I didn't find anything that suits my needs.
<br>If you have any suggestions for improvements, please let me know.
