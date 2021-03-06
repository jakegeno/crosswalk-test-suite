/*
Copyright (c) 2013 Intel Corporation.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of works must retain the original copyright notice, this list
  of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the original copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.
* Neither the name of Intel Corporation nor the names of its contributors
  may be used to endorse or promote products derived from this work without
  specific prior written permission.

THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Authors:
        Shentu, Jiazhen <jiazhenx.shentu@intel.com>

*/

function ab2str(buf) {
    return String.fromCharCode.apply(null, new Uint8Array(buf));
}

$("#send").live("tap", function () {
    TCPsocket.send($("#socketinput").attr("value"));
    $("#chatbox").text("TCPSocket - send - " + data + "\n" + $("#chatbox").text());
    $("#socketinput").attr("value", "");
});

$(document).live('pageshow', function () {
    var TCPServersocket = new xwalk.experimental.raw_socket.TCPServerSocket({"localPort": 6789});
    $("#chatbox").text("TCPServersocket - Connected");
    TCPServersocket.onconnect = function (connectEvent) {
        connectEvent.connectedSocket.ondata = function (messageEvent) {
            var data = ab2str(messageEvent.data);
            $("#chatbox").text("TCPServersocket - recive - " + data + "\n" + $("#chatbox").text());
            connectEvent.connectedSocket.send(data);
            $("#chatbox").text("TCPServersocket - send - " + data + "\n" + $("#chatbox").text());
        }
    };
    window.TCPsocket = new xwalk.experimental.raw_socket.TCPSocket("127.0.0.1", 6789);
    TCPsocket.onopen = function () {
        TCPsocket.ondata = function (messageEvent) {
            var data = ab2str(messageEvent.data);
            $("#chatbox").text("TCPSocket - recive - " + data + "\n" + $("#chatbox").text());
        };
    };
});
