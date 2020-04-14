local lib = require('CoronaLibrary'):new{name = 'plugin.gpgs', publisherId = 'com.coronalabs'}

local api = {
    achievements = {'load', 'increment', 'reveal', 'setSteps', 'unlock', 'show'},
    events = {'load', 'increment'},
    leaderboards = {'load', 'loadScores', 'submit', 'show'},
    multiplayer = {
        invitations = {'load', 'decline', 'dismiss', 'show', 'setListener', 'removeListener'},
        realtime = {'create', 'join', 'leave', 'sendReliably', 'sendUnreliably', 'getRoom', 'show', 'showSelectPlayers', 'setListeners', 'removeListeners'},
        turnbased = {'load', 'cancel', 'create', 'join', 'finish', 'leave', 'rematch', 'send', 'getMatch', 'show', 'showSelectPlayers', 'setListener', 'removeListener'},
        'getLimits'
    },
    players = {'load', 'loadStats', 'show', 'showCompare'},
    quests = {'load', 'accept', 'claim', 'show', 'showPopup', 'setListener', 'removeListener'},
    requests = {'load', 'accept', 'dismiss', 'getLimits', 'show', 'showSend', 'setListener', 'removeListener'},
    snapshots = {'load', 'open', 'save', 'discard', 'delete', 'resolveConflict', 'getSnapshot', 'getLimits', 'show'},
    videos = {'isSupported', 'isModeAvailable', 'loadCapabilities', 'getState', 'show', 'setListener', 'removeListener'},
    'enableDebug',
    'init',
    'isConnected',
    'login',
    'logout',
    'getAppId',
    'getAccountName',
    'getServerAuthCode',
    'getSdkVersion',
    'setPopupPosition',
    'loadGame',
    'clearNotifications',
    'loadImage',
    'showSettings'
}

local function setStubs(t, node, path)
    for k, v in pairs(t) do
        if type(v) == 'string' then
            local notice = 'plugin.gpgs: ' .. table.concat(path, '.') .. (#path > 0 and '.' or '') .. v .. '() is not supported on this platform.'
            node[v] = function()
                print(notice)
            end
        elseif type(v) == 'table' then
            table.insert(path, k)
            node[k] = {}
            setStubs(v, node[k], path)
            table.remove(path, #path)
        end
    end
end

setStubs(api, lib, {})

return lib
