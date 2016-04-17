# tvOS-hackathon
Repo for [AppLovin tvOS Hackathon](https://applovin.com/appchallenge)

Sample SoundCloud API Response /tracks/

```
"kind":"track",
	"id":259483294,
	"created_at":"2016/04/17 06:47:45 +0000",
	"user_id":188099926,
	"duration":120121,
	"commentable":true,
	"state":"finished",
	"original_content_size":2403352,
	"last_modified":"2016/04/17 06:47:45 +0000",
	"sharing":"public",
	"tag_list":"\"Starting To Realize\"",
	"permalink":"title-no-1-april-16-2016",
	"streamable":true,
	"embeddable_by":"all",
	"downloadable":true,
	"purchase_url":null,
	"label_id":null,
	"purchase_title":null,
	"genre":"Electronic",
	"title":"title no. 1 April 16 2016",
	"description":"",
	"label_name":null,
	"release":null,
	"track_type":null,
	"key_signature":null,
	"isrc":null,
	"video_url":null,
	"bpm":null,
	"release_year":null,
	"release_month":null,
	"release_day":null,
	"original_format":"mp3",
	"license":"all-rights-reserved",
	"uri":"https://api.soundcloud.com/tracks/259483294",
	"user": {
		"id":188099926,
		"kind":"user",
		"permalink":"user-982249068",
		"username":"Kaliks",
		"last_modified":"2016/04/17 06:05:08 +0000",
		"uri":"https://api.soundcloud.com/users/188099926",
		"permalink_url":"http://soundcloud.com/user-982249068",
		"avatar_url":"https://i1.sndcdn.com/avatars-000213806303-r5ex0j-large.jpg"
		},
	"permalink_url":"http://soundcloud.com/user-982249068/title-no-1-april-16-2016",
	"artwork_url":null,
	"waveform_url":"https://w1.sndcdn.com/bq9peSSxoDqn_m.png",
	"stream_url":"https://api.soundcloud.com/tracks/259483294/stream",
	"download_url":"https://api.soundcloud.com/tracks/259483294/download",
	"playback_count":0,
	"download_count":0,
	"favoritings_count":0,
	"comment_count":0,
	"attachments_uri":"https://api.soundcloud.com/tracks/259483294/attachments"
	}
```

How to push up a subtree to heroku: 
`git subtree push --prefix server heroku master`
