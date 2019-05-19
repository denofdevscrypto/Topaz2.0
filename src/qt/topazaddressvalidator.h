// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef TOPAZ_QT_TOPAZADDRESSVALIDATOR_H
#define TOPAZ_QT_TOPAZADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class TOPAZAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit TOPAZAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** TOPAZ address widget validator, checks for a valid topaz address.
 */
class TOPAZAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit TOPAZAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // TOPAZ_QT_TOPAZADDRESSVALIDATOR_H
