// 获取应用实例
const app = getApp();

Page({
  data: {
    // 轮播图
    imgUrls: [
      "http://q91f46ql6.bkt.clouddn.com/lunbo1.png",
      "http://q91f46ql6.bkt.clouddn.com/lunbo2.png",
      "http://q91f46ql6.bkt.clouddn.com/lunbo3.png",
      "http://q91f46ql6.bkt.clouddn.com/lunbo4.png"
    ],
    logo: '../../images/logo.png',
    indicatorDots: true,
    autoplay: true,
    interval: 5000,
    duration: 300,
    time: "15:20",
    showAdStatus: false,
    showSleepStatus: false,
    showAppointStatus: false,
    adleft: "7%",
    array: [],
    reList: [],
    isiphonex: false,
    isAppoint: false,
    sleep: false,
    appointTime: ""
  },
  onLoad: function () {
    var that = this;
    wx.getUserInfo({
      success: function (res) {
        that.getReduction();
      },
      fail: function (res) {
        
      }
    });
    this.getShopTime();
    var sysinfo = wx.getSystemInfoSync().windowHeight;
    if (sysinfo > 700) {
      this.setData({
        isiphonex: true
      });
    }
  },
  // 自助点单
  golist: function () {
    if (this.data.sleep) {
        this.setData({
          showSleepStatus: true
        });
    } else {
      wx.navigateTo({
        url: '../list/list?model=0'
      });
    }
  },
  getShopTime: function () {
    var that = this;
    wx.showLoading({});
    // 获取我的订单
    wx.request({
      url: app.globalData.apiHost + '/getShopTime?openid=' + wx.getStorageSync('openId'),
      method: 'GET',
      header: {
        'Accept': 'application/json'
      },
      success: function (res) {
        var openTime = res.data.data.openTime;
        var closeTime = res.data.data.closeTime;
        var timeRange = [];
        var d = new Date();
        var now_h = d.getHours();
        var now_m = d.getMinutes();
        console.log("getShopTime - currentHours = " + now_h);
        console.log("getShopTime - currentMinutes = " + now_m);
        // 当处于9:00以前 22:00以后时
        if (now_h < openTime || now_h > closeTime - 1) {
          that.setData({ sleep: true });
          //从9点开始每隔10分钟
          for (let i = openTime; i < closeTime; i++) {
            for (let j = 0; j < 60; j += 10) {
              if (j == 0) {
                timeRange.push(i + ":00");
              } else {
                timeRange.push(i + ":" + j);
              }
            }
          }
        } else {
          // 处于营业时间则需提前半小时
          console.log(now_m);
          now_m = parseInt(now_m/10) + 3;
          console.log(now_m);
          if (now_m > 5) {
            now_m = (now_m - 6)*10;
            console.log(now_m);
            now_h += 1;
          } else {
            now_m *= 10;
          }
          for (let i = now_h; i < closeTime; i++) {
            for (let j = now_m; j < 60; j += 10) {
              if (j == 0) {
                timeRange.push(i + ":00");
              } else {
                timeRange.push(i + ":" + j);
              }
            }
          }
        }
        that.setData({ array: timeRange });
        wx.hideLoading();
      }
    });
  },
  goOrderlist: function () {
    wx.navigateTo({
      url: '../order/list/list'
    });
  },
  goMine: function () {
    wx.navigateTo({
      url: '../mine/mine'
    });
  },
  letAppoint: function () {
    this.setData({
      isAppoint:true,
      showAppointStatus: true
    });
  },
  // 获取可领的优惠券列表
  getReduction: function () {
    var that = this;
    wx.showLoading({});
    // 获取我的订单
    wx.request({
      url: app.globalData.apiHost + '/getUserCanUseReductionList?openid=' + wx.getStorageSync('openId'),
      method: 'GET',
      header: {
        'Accept': 'application/json'
      },
      success: function (res) {
        console.log("response from UserCanUseReductionList : ", res.data);
        let showAdStatus = false;
        let len = res.data.msg.length > 2 ? 2 : res.data.msg.length;
        for (let i = 0; i < len; i++) {
          console.log("typeDes = " + res.data.msg[i].typeDes + ", isR = " + res.data.msg[i].isR);
          if (res.data.msg[i].isR == 0) {
            showAdStatus = true;
          }
        }
        that.setData({
          reList: res.data.msg,
          showAdStatus: showAdStatus,
        });
        wx.hideLoading();
      }
    });
  },
  // 领取优惠券
  getCut: function (e) {
    var that = this;
    var reduction = e.currentTarget.dataset.reduction
    console.log(e.currentTarget.dataset)
    //获取我的订单
    wx.request({
      url: app.globalData.apiHost +'/getCut?openid=' + wx.getStorageSync('openId') + "&reduction=" + reduction,
      method: 'GET',
      data: {},
      header: {
        'Accept': 'application/json'
      },
      success: function (res) {
        console.log(res.data)
        wx.showToast({
          title: '领取成功',
          icon: 'succes',
          duration: 1000,
          mask: true
        })
        that.getReduction();
      }
    })
  },
  powerDrawer: function (e) {
    var type = e.currentTarget.dataset.type;
    var currentStatus = e.currentTarget.dataset.status;
    console.log("powerDrawer-type", type);
    console.log("powerDrawer-currentStatus", currentStatus);
    if (type == 2) {
      wx.showToast({
        title: '领取成功',
        icon: 'succes',
        duration: 1000,
        mask: true
      });
    }
    this.util(currentStatus);
  },
  bindPickerChange: function (e) {
    console.log('picker发送选择改变，携带值为', this.data.array[e.detail.value])
    this.setData({
      appointTime: this.data.array[e.detail.value]
    })
    // this.goAppoint(this.data.array[e.detail.value])
  },
  closeAP:function(){
    this.setData({
        isAppoint:false,
        showAppointStatus:false
      })
  },
  //预约点单
  goAppoint: function (time) {
    wx.navigateTo({
      url: '../list/list?model=1&appointTime=' + this.data.appointTime
    });
  },
  util: function (currentStatus) {
    /* 动画部分 */
    // 第1步：创建动画实例
    var animation = wx.createAnimation({
      duration: 500, // 动画时长
      timingFunction: "linear", // 线性
      delay: 100 // 0 则不延迟
    });
    // 第2步：这个动画实例赋给当前的动画实例
    this.animation = animation;
    // 第3步：执行第一组动画
    animation.opacity(0).rotateX(-100).step();
    // 第4步：导出动画对象赋给数据对象储存
    this.setData({
      animationData: animation.export()
    });
    // 第5步：设置定时器到指定时候后，执行第二组动画  
    setTimeout(function () {
      // 执行第二组动画  
      animation.opacity(1).rotateX(0).step();
      // 给数据对象储存的第一组动画，更替为执行完第二组动画的动画对象  
      this.setData({
        animationData: animation
      });
      // 关闭  
      if (currentStatus == "close") {
        this.setData({ showAdStatus: false });
      }
      if (currentStatus == "close2") {
        this.setData({ showSleepStatus: false });
      }
      if (currentStatus == "close3") {
        this.setData({ isAppoint: false, showAppointStatus: false });
      }
    }.bind(this), 500);
    // 显示  
    if (currentStatus == "open") {
      this.setData({ showAdStatus: true });
    }
  }
});
