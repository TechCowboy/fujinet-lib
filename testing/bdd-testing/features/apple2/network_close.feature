Feature: library test - apple2 network_close

  This tests fujinet-network apple2 network_close

  Scenario: execute apple2 _network_close with non-0 network id
    Given apple2-fn-nw application test setup
      And I add common apple2-sp files
      And I add apple2 src file "network_close.s"
      And I add common src file "network_unit.s"
      And I add file for compiling "features/apple2/invokers/test_network_close.s"
      And I create and load apple-single application using crt-file "features/apple2/stubs/crt0.s"
      And I write string "n5:foo" as ascii to memory address $a012
      And I write word at t_devicespec with hex $a012
      And I write memory at _sp_network with $03
     When I execute the procedure at _init for no more than 250 instructions

    Then I expect register A equal 0
     And I expect register X equal 0
     And I expect to see t_cb_executed equal 1
     # CMD is SP_CMD_CONTROL (4)
     And I expect to see spe_cmd equal $4
     # DEST is smartport NETWORK device (3)
     And I expect to see spe_dest equal 3
     # 'C' control code
     And I expect to see _sp_cmdlist+4 equal 67

  Scenario: execute apple2 _network_close when network id is unsetl
    Given apple2-fn-nw application test setup
      And I add common apple2-sp files
      And I add apple2 src file "network_close.s"
      And I add common src file "network_unit.s"
      And I add file for compiling "features/apple2/invokers/test_network_close.s"
      And I create and load apple-single application using crt-file "features/apple2/stubs/crt0.s"
      And I write string "n5:foo" as ascii to memory address $a012
      And I write word at t_devicespec with hex $a012
      And I write memory at _sp_network with $00
     When I execute the procedure at _init for no more than 120 instructions

    Then I expect register A equal 1
     And I expect register X equal 0
     And I expect to see t_cb_executed equal 0