import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {
  Table, Icon, Modal, Button,
} from 'semantic-ui-react';

const web3 = require('web3');

class ModalInfoId extends Component {
  static propTypes = {
    txs: PropTypes.array,
  };

  static defaultProps = {
    txs: [{ idx: 0, amount: 0 }],
  };

  getIdTokens = () => {
    try {
      const { txs } = this.props;
      return txs.map((key, index) => {
        return (
          <Table.Row key={index}>
            <Table.Cell>{key.idx}</Table.Cell>
            <Table.Cell>{web3.utils.fromWei(key.amount, 'ether')}</Table.Cell>
          </Table.Row>
        );
      });
    } catch (err) {
      return (
        <Table.Row>
          <Table.Cell>0</Table.Cell>
          <Table.Cell>0</Table.Cell>
        </Table.Row>
      );
    }
  }

  render() {
    return (
      <Modal trigger={<Button icon="info" circular size="mini" />} closeIcon>
        <Modal.Header><Icon name="info" /></Modal.Header>
        <Modal.Content>
          <Table>
            <Table.Header>
              <Table.Row>
                <Table.HeaderCell>ID</Table.HeaderCell>
                <Table.HeaderCell>TOKENS</Table.HeaderCell>
              </Table.Row>
            </Table.Header>
            <Table.Body>
              {this.getIdTokens()}
            </Table.Body>
          </Table>
        </Modal.Content>
      </Modal>
    );
  }
}

export default ModalInfoId;
