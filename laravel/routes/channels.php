<?php

use Illuminate\Support\Facades\Broadcast;

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/

Broadcast::channel('home', function ($user) {
   return true;
//     return (int) $user->id === 1;//(int) $id;
});

Broadcast::channel('chat.{id}', function ($user, $id) {
//    dd("SAa")
    return true;
});
