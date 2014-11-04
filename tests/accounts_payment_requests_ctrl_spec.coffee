describe "AccountsPaymentRequestsCtrl", ->
  scope = undefined
  
  modal =
    open: ->
  
  beforeEach angular.mock.module("walletApp")
  
  beforeEach ->
    angular.mock.inject ($injector, $rootScope, $controller) ->
      Wallet = $injector.get("Wallet")
      MyWallet = $injector.get("MyWallet")
      
      Wallet.login("test", "test")  
      
      scope = $rootScope.$new()
            
      $controller "AccountsPaymentRequestsCtrl",
        $scope: scope,
        $stateParams: {}
        $modal: modal
      
      return

    return
    
  it "should let user create a new address",  inject(($state) ->
    before = scope.accounts.length
    spyOn($state, "go")
    scope.createAccount()
    expect(scope.accounts.length).toBe(before + 1)
    expect($state.go).toHaveBeenCalledWith("transactions", { accountIndex : 2 } )
  )
    
    
  it "should show incomplete payment requests",  inject((Wallet) ->
    Wallet.generatePaymentRequestForAccount(0, numeral(1))
    expect(scope.requests.length).toBe(1)
  )
  
  it "should open a popup with the payment request",  inject((Wallet, $modal) ->
    Wallet.generatePaymentRequestForAccount(0, numeral(1))
    req = scope.requests[0]
    spyOn(modal, "open")

    scope.open(req)

    expect(modal.open).toHaveBeenCalled()
  )