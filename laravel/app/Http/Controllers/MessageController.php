<?php

namespace App\Http\Controllers;

use App\Conversation;
use App\Events\NewMessage;
use App\Http\Resources\ConversationResource;
use App\Http\Resources\MessageResource;
use App\Message;
use Carbon\Carbon;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MessageController extends Controller
{
    public function recieve(Request $request) {
//        $request->user_id = auth()->user()->id;
        $conversation = new Message();
        $conversation->body = $request->body;
        $conversation->user_id = auth()->user()->id;
        $conversation->conversation_id = $request->conversation_id;
        $conversation->created_at = Carbon::now();
        if($conversation->save()){
            Broadcast(new NewMessage(json_encode($conversation)))->toOthers();
            return response()->json(['success' => 'your message has been sent']);
        }else{
            return response()->json(['error' => 'filled to send']);
        }
//         return auth()->user()->id;

    }
    public function conversations() {

    $conversations=    DB::select("select u.name 'user_name' ,u.avatar 'avatar',u.id 'recivier_id',m.body 'last_message', c.id 'conversation_id', m.created_at 'created'  from conversations c join (SELECT m1.*
FROM messages m1 LEFT JOIN messages m2
 ON (m1.conversation_id = m2.conversation_id AND m1.id < m2.id)
WHERE m2.id IS NULL) m on m.conversation_id = c.id JOIN users u ON (u.id = c.second_user_id) where c.user_id =? or c.second_user_id =?", [1,1]);
        return new ConversationResource($conversations);
        // return Conversation::join('messages','messages.id','=','conversation_id')->get();//->where('conversations.user_id',1)->orWhere('conversations.second_user_id',1)->get();


//         select u.name 'user_name',m.body 'last_message', c.id 'conversation_id'  from conversations c join (SELECT m1.*
// FROM messages m1 LEFT JOIN messages m2
//  ON (m1.conversation_id = m2.conversation_id AND m1.id < m2.id)
// WHERE m2.id IS NULL) m on m.conversation_id = c.id JOIN users u ON (u.id = c.second_user_id) where c.user_id =1
    }
    public function messages($conversation_id) {
        $message = Message::join('conversations','conversations.id','=','messages.conversation_id')->where('messages.conversation_id','=',$conversation_id)->get(['messages.body','messages.user_id']);
        return new MessageResource($message);
    }
}
