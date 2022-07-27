#Inheritance Deed initiated by the owner() ---> Inheritor 

valueOfDeed: public(uint156) #Value of the perticular deed to be specified by the owner.
ownerOfDeed: public(address)
inheritorOfDeed: public(address)
deedUnlocked: public(bool)
deedEnded: public(bool)

@external
@payable
def __init__Deed():
    assert  msg.valueOfDeed % 1) == 0
    self.valueOfDeed = msg.valueOfDeed / 1  # The ownerOfDeed initializes the contract by
     # creating a gnosis-safe A/c by depositing {x tokens/crypto}*valueOfDeed for inheritor 
     # after he's gonna die [sad :()]
     # TODO : CREATE GNOSIS SAFE A/C BY USING FR SDK [REACT] !!
    self.ownerOfDeed = msg.sender
    self.deedUnlocked = True

@external
def abortDeed():
    assert self.deedUnlocked #Is the contract still refundable/returnable ??
    assert msg.sender == self.ownerOfDeed # Only when the ownerOfDeed can callback !!
        # his deposit before inheritorOfDeed grab it..no matter what cause he's gonna die at that time lol [sorry sad :P]
    selfdestruct(self.ownerOfDeed) # if something fails,value should be Refunded to the ownerOfDeed and deletes the contract.

@external
@payable
def givenDeed():
  assert self.deedUnlocked # Is the contract still open (is the deed still up for inheritance) ??
    assert msg.valueOfDeed == (1 * self.valueOfDeed) # Is the deposit the correct valueOfDeed?
    self.inheritorOfDeed = msg.sender
    self.deedUnlocked = False

@external
def receivedDeed():
    # 1. Extra Conditions fullfilled --->
    assert not self.deedUnlocked # Is the deed already inherited or still pending??
                           # confirmation from the inheritorOfDeed !!
    assert msg.sender == self.inheritorOfDeed
   assert not self.deedEnded

   # 2. What we gonna do ?? ---> Execute it :)
    self.deedEnded = True

    # 3. Interaction
   send(self.inheritorOfDeed, self.valueOfDeed) # Return the inheritorOfDeed's deposit (=valueOfDeed) to the inheritorOfDeed.
   selfdestruct(self.ownerOfDeed) # Return the ownerOfDeed's deposit (=1*valueOfDeed) and the
                             # original deed value (=valueOfDeed) to the ownerOfDeed.
