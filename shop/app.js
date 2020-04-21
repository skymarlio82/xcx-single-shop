App({
  onLaunch: function () {
    var that = this;
    // 登录
    wx.login({
      success: res => {
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
        console.log("微信登录成功后, 得到的授权码: " + res.code);
        let openId = wx.getStorageSync('openId');
        console.log("openId in LocalStorage = " + openId);
        // 如果没有openId的话则先获取并保存在本地
        wx.request({
          url: that.globalData.apiHost + '/getUserOpenId?code=' + res.code,
          success: function (res1) {
            console.log("response from 'getUserOpenId' with code", res1);
            openId = res1.data.msg.openid;
            var session_key = res1.data.msg.session_key;
            console.log("openId = " + openId);
            console.log("session_key = " + session_key);
            wx.setStorageSync('openId', openId);
            wx.setStorageSync('session_key', session_key);
            // openID获取成功后则首次拉取用户信息并保存在本地
            let userInfo = wx.getStorageSync('userInfo');
            if (!userInfo) {
              wx.getUserInfo({
                success: function (res2) {
                  var userInfo = res2.userInfo;
                  userInfo.openId = openId;
                  wx.setStorageSync('userInfo', res2.userInfo);
                  // 用户信息获取成功 则开始首次用户注册
                  wx.request({
                    url: that.globalData.apiHost + '/register',
                    method: 'POST',
                    data: userInfo,
                    dataType: 'json',
                    header: {
                      'content-type': 'application/json'
                    },
                    success: function (res) {
                      console.log("Auto-register success : ", res.data);
                    }
                  });
                },
                fail: function (err) {
                  wx.showModal({
                    title: '一键注册',
                    content: '欢迎使用奈茶水峰自助点餐服务,请进入[个人中心]，完成一键注册',
                    showCancel: false,
                    success: function (res) {
                      if (res.confirm) {
                        wx.navigateTo({
                          url: '../mine/mine'
                        });
                      }
                    }
                  });
                }
              });
            } else {
              wx.request({
                url: that.globalData.apiHost + '/login?openId=' + wx.getStorageSync('openId'),
                header: {
                  'content-type': 'application/json'
                },
                success: function (res) {
                  console.log("Auto-login success : ", res.data);
                }
              });
            }
          }
        });
      }
    });
    // 获取用户信息
    wx.getSetting({
      success: res => {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权, 可以直接调用getUserInfo获取头像昵称, 不会弹框
          wx.getUserInfo({
            success: res => {
              // 可以将res发送给后台解码出unionId
              this.globalData.userInfo = res.userInfo;
              console.log('wx.userInfo: ', this.globalData.userInfo);
              // 由于getUserInfo是网络请求, 可能会在Page.onLoad之后才返回, 所以此处加入callback以防止这种情况
              if (this.userInfoReadyCallback) {
                this.userInfoReadyCallback(res);
              }
            }
          });
        }
      }
    });
  },
  globalData: {
    userInfo: null,
    openId: null,
    apiHost: "https://www.sky888.cn/diancan"
  }
});