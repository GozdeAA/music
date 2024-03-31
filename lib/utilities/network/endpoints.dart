//codes below are required for deezer

const appId = 641921;
const appSecret = "f8d516fae91e5a757175d6e954a10288";
const redirectUrl = "https://www.bbshfistik.com/";
const authUrl =
    "https://connect.deezer.com/oauth/auth.php?app_id=$appId&redirect_uri=$redirectUrl&secret=$appSecret&perms=basic_access,email";

const tokenUrl =
    "https://connect.deezer.com/oauth/access_token.php?app_id=$appId&secret=$appSecret&code=";
