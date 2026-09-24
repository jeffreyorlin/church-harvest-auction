CAMERA LIVE FIX

Updated camera.html, bid.html and tv.html.

Changes:
- Buffers WebRTC ICE candidates that arrive before the remote SDP is set.
- Applies queued candidates after the remote description is available.
- Adds WebRTC connection-state monitoring.
- Uses safer video bitrate settings for mobile networks.
- Cleans up disconnected peer state on the camera broadcaster.

IMPORTANT:
This fixes a common WebRTC signaling/ICE race that can make the camera work on one phone but fail on another.
If two phones are on networks that cannot establish a direct peer-to-peer path, STUN alone may still fail. In that case the site needs a TURN server (with valid TURN credentials) for reliable cross-network connectivity.

The project currently uses Google STUN servers only; no TURN credentials were invented or embedded.
